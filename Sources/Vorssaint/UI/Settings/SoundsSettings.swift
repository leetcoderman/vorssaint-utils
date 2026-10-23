// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import SwiftUI

/// Every sound the app can make for a moment, grouped by the feature whose
/// moments they mark, each with its own switch, sound and loudness.
struct SoundsSettings: View {
    @ObservedObject private var l10n = L10n.shared
    /// Redraws when a feature with sounds is installed or removed.
    @ObservedObject private var features = FeatureRuntime.shared
    @AppStorage(DefaultsKey.soundsEnabled) private var enabled = true
    /// Read so the note about the AI page follows it while this page is open.
    @AppStorage(DefaultsKey.notchAgentsEnabled) private var agentsEnabled = false
    @AppStorage(DefaultsKey.notchEnabled) private var islandEnabled = false

    private var text: SoundStrings { FeatureStrings.sounds(l10n.language) }

    private var agentSounds: [AppSound] {
        AppSound.allCases.filter { $0.feature == .notchAgents && features.isAvailable($0.feature) }
    }

    var body: some View {
        Form {
            Section {
                Toggle(text.playSounds, isOn: $enabled)
                Text(text.caption)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if !agentSounds.isEmpty {
                Section {
                    if !NotchAgentSupport.isEnabled() {
                        Text(text.agentsOff)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    ForEach(agentSounds) { sound in
                        AppSoundRow(sound: sound, text: text, language: l10n.language)
                    }
                } header: {
                    Text(text.agentsTitle)
                }
                .disabled(!enabled)
            }
        }
        .formStyle(.grouped)
    }
}

/// One moment: its switch, then the sound and how loud it plays.
private struct AppSoundRow: View {
    let sound: AppSound
    let text: SoundStrings
    let language: AppLanguage
    @AppStorage private var on: Bool
    @AppStorage private var name: String
    @AppStorage private var volume: Double

    init(sound: AppSound, text: SoundStrings, language: AppLanguage) {
        self.sound = sound
        self.text = text
        self.language = language
        _on = AppStorage(wrappedValue: false, sound.enabledKey)
        _name = AppStorage(wrappedValue: sound.defaultName, sound.nameKey)
        _volume = AppStorage(wrappedValue: sound.defaultVolume, sound.volumeKey)
    }

    private var title: String {
        switch sound {
        case .agentFinished: return text.finished
        case .agentStarted: return text.started
        }
    }

    private var caption: String {
        switch sound {
        case .agentFinished: return text.finishedCaption
        case .agentStarted: return text.startedCaption
        }
    }

    var body: some View {
        SettingsRow(symbol: sound.symbol, title: title, caption: caption) {
            Toggle(title, isOn: $on).labelsHidden().toggleStyle(.switch)
        }
        if on {
            SettingsMenuRow(symbol: nil, title: text.sound, selection: $name) {
                ForEach(AlertSoundStrings.sortedNames(TextSnippetSupport.alertSoundNames, language: language),
                        id: \.self) { option in
                    Text(AlertSoundStrings.displayName(for: option, language: language)).tag(option)
                }
                // A name saved on another Mac keeps a row, or the menu would
                // show nothing chosen.
                if !TextSnippetSupport.alertSoundNames.contains(name) {
                    Text(text.unavailable).tag(name)
                }
            }
            .padding(.leading, settingsRowTextInset)
            .onChange(of: name) { _, _ in AppSoundService.shared.preview(sound) }
            HStack(spacing: 10) {
                Text(text.volume)
                Image(systemName: "speaker.fill").foregroundStyle(.secondary)
                Slider(value: $volume, in: AppSoundSupport.minimumVolume...1) { editing in
                    if !editing { AppSoundService.shared.preview(sound) }
                }
                .labelsHidden()
                Image(systemName: "speaker.wave.3.fill").foregroundStyle(.secondary)
                Button(text.play) { AppSoundService.shared.preview(sound) }
            }
            .padding(.leading, settingsRowTextInset)
        }
    }
}
