// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import AVFoundation

/// Plays the app's sounds, each at its own loudness and repeat count, on the
/// main thread. A sound set above full is boosted and held under the
/// output's ceiling by a peak limiter, so it gets louder
/// without crackling.
final class AppSoundService {
    static let shared = AppSoundService()

    /// The pause between repeats of one sound.
    static let repeatGap: TimeInterval = 0.25
    /// How long the engine stays up after the last sound, so a burst of
    /// moments does not restart it each time, while the output can still
    /// sleep between them.
    private static let idleStop: TimeInterval = 3

    let library = AppSoundLibrary.shared
    private var lastPlayed: [AppSound: Date] = [:]
    private let engine = AVAudioEngine()
    /// One player per moment, so a new sound for a moment cuts its last one
    /// short while other moments' sounds play on.
    private var players: [AppSound: AVAudioPlayerNode] = [:]
    private var playing = 0
    private var idleTimer: Timer?

    private init() {}

    /// Plays the sound for a moment when it is switched on.
    func play(_ sound: AppSound, now: Date = Date()) {
        guard AppSoundSupport.isOn(sound), AppSoundSupport.isDue(after: lastPlayed[sound], now: now) else { return }
        lastPlayed[sound] = now
        preview(sound)
    }

    /// Plays the chosen sound as set, switched on or not.
    func preview(_ sound: AppSound) {
        guard let choice = AppSoundSupport.choice(sound, library: library),
              let url = library.url(for: choice),
              let buffer = Self.render(url, gain: Float(AppSoundSupport.volume(sound)),
                                       repeats: AppSoundSupport.repeats(sound)) else { return }
        let player = players[sound] ?? attach(for: sound, format: buffer.format)
        player.stop()
        if engine.outputNode.outputFormat(forBus: 0).sampleRate == 0 { return }
        engine.disconnectNodeOutput(player)
        engine.connect(player, to: engine.mainMixerNode, format: buffer.format)
        guard start() else { return }
        playing += 1
        player.scheduleBuffer(buffer, completionCallbackType: .dataPlayedBack) { [weak self] _ in
            DispatchQueue.main.async { self?.finished() }
        }
        player.play()
    }

    private func attach(for sound: AppSound, format: AVAudioFormat) -> AVAudioPlayerNode {
        let player = AVAudioPlayerNode()
        engine.attach(player)
        players[sound] = player
        return player
    }

    private func start() -> Bool {
        idleTimer?.invalidate()
        idleTimer = nil
        guard !engine.isRunning else { return true }
        engine.prepare()
        do { try engine.start() } catch { return false }
        return true
    }

    private func finished() {
        playing = max(0, playing - 1)
        guard playing == 0 else { return }
        idleTimer?.invalidate()
        idleTimer = Timer.scheduledTimer(withTimeInterval: Self.idleStop, repeats: false) { [weak self] _ in
            guard let self, self.playing == 0 else { return }
            self.engine.stop()
        }
    }

    /// The file at `gain`, `repeats` times with a short pause between, in
    /// one buffer. Peaks a boost would push past full scale are limited.
    static func render(_ url: URL, gain: Float, repeats: Int) -> AVAudioPCMBuffer? {
        guard let file = try? AVAudioFile(forReading: url),
              file.length > 0, file.length < AVAudioFramePosition(Int32.max),
              let source = AVAudioPCMBuffer(pcmFormat: file.processingFormat,
                                            frameCapacity: AVAudioFrameCount(file.length)),
              (try? file.read(into: source)) != nil else { return nil }
        let format = source.format
        let channels = Int(format.channelCount)
        let frames = Int(source.frameLength)
        let gap = Int(format.sampleRate * repeatGap)
        let count = max(1, repeats)
        let total = frames * count + gap * (count - 1)
        guard channels > 0, let output = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(total)),
              let input = source.floatChannelData, let target = output.floatChannelData else { return nil }
        output.frameLength = AVAudioFrameCount(total)
        // Interleaved, as the limiter takes it.
        var samples = [Float](repeating: 0, count: total * channels)
        for pass in 0..<count {
            let start = pass * (frames + gap)
            for frame in 0..<frames {
                for channel in 0..<channels {
                    samples[(start + frame) * channels + channel] = input[channel][frame] * gain
                }
            }
        }
        if gain > 1 {
            var limiter = BoostLimiter()
            let release = BoostLimiter.release(sampleRate: format.sampleRate)
            samples.withUnsafeMutableBufferPointer {
                if let base = $0.baseAddress { limiter.process(base, frames: total, channels: channels, release: release) }
            }
        }
        for frame in 0..<total {
            for channel in 0..<channels { target[channel][frame] = samples[frame * channels + channel] }
        }
        return output
    }
}
