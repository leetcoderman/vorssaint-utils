// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// A moment the app can mark with a sound. Each has its own switch, sound,
/// loudness and repeat count, so a moment worth looking up for can ring out
/// while a routine one only ticks.
///
/// Adding a moment: a case here, its group, feature, symbol and defaults
/// below, and its title and caption in its group's strings. Its preference
/// keys follow from the case name.
enum AppSound: String, CaseIterable, Identifiable {
    /// An agent's turn ends: the work is done and waits for you.
    case agentFinished
    /// An agent's turn opens.
    case agentStarted
    /// The battery falls to the low mark while on battery.
    case batteryLow
    /// A charger is plugged in.
    case chargerConnected
    /// The charger is unplugged.
    case chargerDisconnected
    /// A timed Keep Awake session runs out.
    case keepAwakeEnded

    var id: String { rawValue }

    var group: AppSoundGroup {
        switch self {
        case .agentFinished, .agentStarted: return .agents
        case .batteryLow, .chargerConnected, .chargerDisconnected, .keepAwakeEnded: return .power
        }
    }

    /// The feature whose events play it; it is offered only while installed.
    var feature: AppFeature {
        switch self {
        case .agentFinished, .agentStarted: return .notchAgents
        case .batteryLow, .chargerConnected, .chargerDisconnected: return .monitorPower
        case .keepAwakeEnded: return .keepAwake
        }
    }

    var symbol: String {
        switch self {
        case .agentFinished: return "checkmark.circle"
        case .agentStarted: return "play.circle"
        case .batteryLow: return "battery.25percent"
        case .chargerConnected: return "bolt.fill"
        case .chargerDisconnected: return "bolt.slash"
        case .keepAwakeEnded: return "cup.and.saucer"
        }
    }

    /// A choice from `AppSoundLibrary`: a full chime for work that is done,
    /// a lighter one for work beginning. A low battery gets an alert, the
    /// charger a short click each way.
    var defaultChoice: String {
        switch self {
        case .agentFinished: return "tone:Modern/Chord"
        case .agentStarted: return "tone:Modern/Aurora"
        case .batteryLow: return "tone:Classic/Alert"
        case .chargerConnected: return "tone:Modern/Input"
        case .chargerDisconnected: return "tone:Modern/Keys"
        case .keepAwakeEnded: return "tone:Modern/Complete"
        }
    }

    var defaultVolume: Double {
        switch self {
        case .agentFinished: return 1.5
        case .agentStarted: return 1
        case .batteryLow: return 1.5
        case .chargerConnected, .chargerDisconnected, .keepAwakeEnded: return 1
        }
    }

    var defaultRepeats: Int { 1 }

    // MARK: Keys

    /// `soundAgentFinished`, and the same with `Name`, `Volume` and `Repeats`.
    var enabledKey: String { "sound" + rawValue.prefix(1).uppercased() + rawValue.dropFirst() }
    var nameKey: String { enabledKey + "Name" }
    var volumeKey: String { enabledKey + "Volume" }
    var repeatsKey: String { enabledKey + "Repeats" }

    /// Every moment starts off, with its own sound, loudness and repeats.
    static var registeredDefaults: [String: Any] {
        var values: [String: Any] = [:]
        for sound in allCases {
            values[sound.enabledKey] = false
            values[sound.nameKey] = sound.defaultChoice
            values[sound.volumeKey] = sound.defaultVolume
            values[sound.repeatsKey] = sound.defaultRepeats
        }
        return values
    }
}

/// A section of the Sounds page, in page order.
enum AppSoundGroup: String, CaseIterable, Identifiable {
    case agents
    case power

    var id: String { rawValue }

    var sounds: [AppSound] { AppSound.allCases.filter { $0.group == self } }

    /// Whether the section's note shows: its sounds wait on a setting
    /// elsewhere.
    var noteApplies: Bool {
        switch self {
        case .agents: return !NotchAgentSupport.isEnabled()
        case .power: return !PowerSoundSupport.hasInternalBattery
        }
    }

    /// Its section title and each moment's words.
    func strings(_ language: AppLanguage) -> SoundGroupStrings {
        switch self {
        case .agents: return FeatureStrings.agentSounds(language)
        case .power: return FeatureStrings.powerSounds(language)
        }
    }
}

enum AppSoundSupport {
    /// The quietest a sound may be set: quieter reads as broken, and the
    /// switch is there to silence it.
    static let minimumVolume = 0.05
    /// Above full, the sound is boosted and held under the output's ceiling.
    static let maximumVolume = 2.0
    static let repeatChoices = [1, 2, 3]
    /// Several agents starting or finishing together are heard once.
    static let minimumGap: TimeInterval = 1.5

    static func isOn(_ sound: AppSound, in defaults: UserDefaults = .standard,
                     isAvailable: (AppFeature) -> Bool = { $0.isAvailable }) -> Bool {
        isAvailable(sound.feature)
            && defaults.object(forKey: DefaultsKey.soundsEnabled) as? Bool ?? true
            && defaults.bool(forKey: sound.enabledKey)
    }

    /// The stored choice, or this moment's own when the stored one is not
    /// on this Mac, as when settings came from another.
    static func choice(_ sound: AppSound, in defaults: UserDefaults = .standard,
                       library: AppSoundLibrary = .shared) -> AppSoundChoice? {
        if let stored = defaults.string(forKey: sound.nameKey).flatMap(AppSoundChoice.init(id:)),
           library.url(for: stored) != nil {
            return stored
        }
        if let own = AppSoundChoice(id: sound.defaultChoice), library.url(for: own) != nil { return own }
        return library.choices.first
    }

    static func volume(_ sound: AppSound, in defaults: UserDefaults = .standard) -> Double {
        let value = defaults.object(forKey: sound.volumeKey) as? Double ?? sound.defaultVolume
        return value.isFinite ? min(maximumVolume, max(minimumVolume, value)) : sound.defaultVolume
    }

    static func repeats(_ sound: AppSound, in defaults: UserDefaults = .standard) -> Int {
        let value = defaults.object(forKey: sound.repeatsKey) as? Int ?? sound.defaultRepeats
        return min(repeatChoices.last ?? 1, max(1, value))
    }

    static func isDue(after last: Date?, now: Date) -> Bool {
        guard let last else { return true }
        return now.timeIntervalSince(last) >= minimumGap || now < last
    }
}
