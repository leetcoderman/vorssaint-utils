// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// A moment the app can mark with a sound. Each has its own switch, alert
/// sound and loudness, so a moment worth looking up for can ring out while
/// a routine one only ticks.
enum AppSound: String, CaseIterable, Identifiable {
    /// An agent's turn ends: the work is done and waits for you.
    case agentFinished
    /// An agent's turn opens.
    case agentStarted

    var id: String { rawValue }

    /// The feature whose events play it; it is offered only while installed.
    var feature: AppFeature {
        switch self {
        case .agentFinished, .agentStarted: return .notchAgents
        }
    }

    var symbol: String {
        switch self {
        case .agentFinished: return "checkmark.circle"
        case .agentStarted: return "play.circle"
        }
    }

    var enabledKey: String {
        switch self {
        case .agentFinished: return DefaultsKey.soundAgentFinished
        case .agentStarted: return DefaultsKey.soundAgentStarted
        }
    }

    var nameKey: String {
        switch self {
        case .agentFinished: return DefaultsKey.soundAgentFinishedName
        case .agentStarted: return DefaultsKey.soundAgentStartedName
        }
    }

    var volumeKey: String {
        switch self {
        case .agentFinished: return DefaultsKey.soundAgentFinishedVolume
        case .agentStarted: return DefaultsKey.soundAgentStartedVolume
        }
    }

    /// A full chime for work that is done, a soft tick for work beginning.
    var defaultName: String {
        switch self {
        case .agentFinished: return "Hero"
        case .agentStarted: return "Tink"
        }
    }

    var defaultVolume: Double {
        switch self {
        case .agentFinished: return 1
        case .agentStarted: return 0.35
        }
    }
}

enum AppSoundSupport {
    /// The quietest a sound may be set: quieter reads as broken, and the
    /// switch is there to silence it.
    static let minimumVolume = 0.05
    /// Several agents starting or finishing together are heard once.
    static let minimumGap: TimeInterval = 1.5

    static func isOn(_ sound: AppSound, in defaults: UserDefaults = .standard,
                     isAvailable: (AppFeature) -> Bool = { $0.isAvailable }) -> Bool {
        isAvailable(sound.feature)
            && defaults.object(forKey: DefaultsKey.soundsEnabled) as? Bool ?? true
            && defaults.bool(forKey: sound.enabledKey)
    }

    /// The stored alert sound, or this one's own when the stored name is
    /// not on this Mac, as when settings came from another.
    static func name(_ sound: AppSound, in defaults: UserDefaults = .standard,
                     available: [String] = TextSnippetSupport.alertSoundNames) -> String? {
        TextSnippetSupport.resolvedSoundName(stored: defaults.string(forKey: sound.nameKey),
                                             available: available, fallback: sound.defaultName)
    }

    static func volume(_ sound: AppSound, in defaults: UserDefaults = .standard) -> Double {
        let value = defaults.object(forKey: sound.volumeKey) as? Double ?? sound.defaultVolume
        return value.isFinite ? min(1, max(minimumVolume, value)) : sound.defaultVolume
    }

    static func isDue(after last: Date?, now: Date) -> Bool {
        guard let last else { return true }
        return now.timeIntervalSince(last) >= minimumGap || now < last
    }
}
