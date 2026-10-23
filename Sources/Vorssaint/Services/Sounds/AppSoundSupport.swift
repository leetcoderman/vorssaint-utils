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
    /// The last of several agents working together finishes.
    case agentsAllDone
    /// An agent waits on your answer or approval, and at each reminder.
    case agentNeedsInput
    /// An agent's turn is interrupted, or an error stops it.
    case agentInterrupted
    /// An agent nears a plan limit, or one renews.
    case agentLimitWarning
    case agentLimitReset
    /// The day's API value passes its budget.
    case agentBudgetReached

    var id: String { rawValue }

    var group: AppSoundGroup {
        switch self {
        case .agentFinished, .agentStarted, .agentsAllDone, .agentNeedsInput, .agentInterrupted,
             .agentLimitWarning, .agentLimitReset, .agentBudgetReached: return .agents
        }
    }

    /// The feature whose events play it; it is offered only while installed.
    var feature: AppFeature {
        switch self {
        case .agentFinished, .agentStarted, .agentsAllDone, .agentNeedsInput, .agentInterrupted,
             .agentLimitWarning, .agentLimitReset, .agentBudgetReached: return .notchAgents
        }
    }

    var symbol: String {
        switch self {
        case .agentFinished: return "checkmark.circle"
        case .agentStarted: return "play.circle"
        case .agentsAllDone: return "checklist.checked"
        case .agentNeedsInput: return "hand.raised"
        case .agentInterrupted: return "pause.circle"
        case .agentLimitWarning: return "exclamationmark.triangle"
        case .agentLimitReset: return "arrow.clockwise"
        case .agentBudgetReached: return "dollarsign.circle"
        }
    }

    /// A choice from `AppSoundLibrary`: a full chime for work that is done,
    /// a lighter one for work beginning, a reminding one for a wait, and a
    /// low one for work that stopped.
    var defaultChoice: String {
        switch self {
        case .agentFinished: return "tone:Modern/Chord"
        case .agentStarted: return "tone:Modern/Aurora"
        case .agentsAllDone: return "tone:Modern/Complete"
        case .agentNeedsInput: return "tone:Modern/Input"
        case .agentInterrupted: return "Basso"
        case .agentLimitWarning: return "tone:Modern/Pulse"
        case .agentLimitReset: return "tone:Modern/Hello"
        case .agentBudgetReached: return "tone:Modern/Note"
        }
    }

    var defaultVolume: Double {
        switch self {
        case .agentFinished, .agentsAllDone, .agentNeedsInput: return 1.5
        case .agentStarted, .agentInterrupted, .agentLimitWarning, .agentLimitReset, .agentBudgetReached: return 1
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

    var id: String { rawValue }

    var sounds: [AppSound] { AppSound.allCases.filter { $0.group == self } }

    /// Whether the section's note shows: its sounds wait on a setting
    /// elsewhere.
    var noteApplies: Bool {
        switch self {
        case .agents: return !NotchAgentSupport.isEnabled()
        }
    }

    /// Its section title and each moment's words.
    func strings(_ language: AppLanguage) -> SoundGroupStrings {
        switch self {
        case .agents: return FeatureStrings.agentSounds(language)
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
