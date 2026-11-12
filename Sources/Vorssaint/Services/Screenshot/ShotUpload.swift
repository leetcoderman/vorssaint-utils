// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// Share links for the screenshot tool: the image goes to ImgBB under the
/// user's own free API key (https://api.imgbb.com) and the direct link to it
/// comes back. Uploads are listed in that ImgBB account, where they can be
/// deleted. Pure request building and answer reading, so the harness can
/// check both without a network.
enum ShotUpload {
    /// ImgBB refuses anything larger.
    static let maxBytes = 32 * 1024 * 1024

    /// The lifetimes offered in the settings, in seconds; 0 keeps the image
    /// until it is deleted.
    static let lifetimes = [0, 3_600, 86_400, 604_800, 2_592_000]

    enum Outcome: Equatable {
        /// The image's direct https link.
        case link(String)
        /// ImgBB's own reason when it gave one.
        case refused(String?)
    }

    /// ImgBB takes 60 seconds to 180 days; 0 or less means no expiry.
    static func expiration(_ seconds: Int) -> Int {
        seconds <= 0 ? 0 : min(max(seconds, 60), 15_552_000)
    }

    /// A pasted key without the spaces or line breaks that tend to come along.
    static func cleanKey(_ key: String?) -> String {
        (key ?? "").filter { !$0.isWhitespace }
    }

    /// ImgBB's documented form: the key and the expiry in the query, the
    /// image in the body.
    static func endpoint(key: String, expiry: Int) -> URL? {
        var components = URLComponents(string: "https://api.imgbb.com/1/upload")
        var items = [URLQueryItem(name: "key", value: cleanKey(key))]
        let seconds = expiration(expiry)
        if seconds > 0 { items.append(URLQueryItem(name: "expiration", value: String(seconds))) }
        components?.queryItems = items
        return components?.url
    }

    static func request(key: String, expiry: Int, boundary: String) -> URLRequest? {
        guard let url = endpoint(key: key, expiry: expiry) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        return request
    }

    /// The multipart body: one part, the image, under the name ImgBB reads.
    static func body(_ data: Data, fileName: String, boundary: String) -> Data {
        let type = fileName.lowercased().hasSuffix(".jpg") ? "image/jpeg" : "image/png"
        let head = "--\(boundary)\r\n"
            + "Content-Disposition: form-data; name=\"image\"; filename=\"\(fileName)\"\r\n"
            + "Content-Type: \(type)\r\n\r\n"
        var body = Data(head.utf8)
        body.append(data)
        body.append(Data("\r\n--\(boundary)--\r\n".utf8))
        return body
    }

    /// Reads ImgBB's JSON answer. Only an https link counts, so an error is
    /// never copied as if it were a link.
    static func parse(_ body: Data) -> Outcome {
        let json = try? JSONSerialization.jsonObject(with: body)
        guard let root = json as? [String: Any] else { return .refused(nil) }
        if let error = root["error"] {
            if let message = (error as? [String: Any])?["message"] as? String,
               !message.isEmpty, message.count <= 200 {
                return .refused(message)
            }
            return .refused(nil)
        }
        guard let data = root["data"] as? [String: Any],
              let text = data["url"] as? String,
              let url = URL(string: text),
              url.scheme == "https",
              let host = url.host, !host.isEmpty
        else { return .refused(nil) }
        return .link(url.absoluteString)
    }
}
