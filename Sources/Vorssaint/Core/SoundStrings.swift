// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// The Sounds page in Settings: what every moment shares. Each group's
/// title and moments are in its own file, beside `agentSounds`.
struct SoundStrings {
    let title: String
    /// Under the page's switch.
    let caption: String
    let playSounds: String
    let sound: String
    let volume: String
    let play: String
    let unavailable: String
    let repeats: String
    let once: String
    /// A repeat count above one, as in "2 times".
    let timesFormat: String
    /// The sections of the sound menu.
    let sourceSystem: String
    let sourceTones: String
    let sourceYours: String
    let addSound: String

    func repeatCount(_ count: Int) -> String { count == 1 ? once : String(format: timesFormat, count) }
}

/// One moment's row.
struct SoundMoment {
    let title: String
    let caption: String
}

/// A section of the Sounds page. `note` shows while the group's
/// `noteApplies`, as when its feature is installed but not switched on.
struct SoundGroupStrings {
    let title: String
    let note: String?
    let moments: [AppSound: SoundMoment]
}

extension FeatureStrings {
    static func sounds(_ language: AppLanguage) -> SoundStrings {
        switch language {
        case .enUS: return SoundStrings(
            title: "Sounds",
            caption: "Choose which moments make a sound, which sound and how loud. Above 100%, a sound is boosted.",
            playSounds: "Play sounds",
            sound: "Sound",
            volume: "Volume",
            play: "Play",
            unavailable: "Not on this Mac",
            repeats: "Repeat",
            once: "Once",
            timesFormat: "%d times",
            sourceSystem: "macOS alerts",
            sourceTones: "Apple tones",
            sourceYours: "Your sounds",
            addSound: "Add a sound…")
        case .ptBR: return SoundStrings(
            title: "Sons",
            caption: "Escolha quais momentos tocam um som, qual som e com que volume. Acima de 100%, o som é amplificado.",
            playSounds: "Tocar sons",
            sound: "Som",
            volume: "Volume",
            play: "Tocar",
            unavailable: "Não está neste Mac",
            repeats: "Repetir",
            once: "Uma vez",
            timesFormat: "%d vezes",
            sourceSystem: "Alertas do macOS",
            sourceTones: "Tons da Apple",
            sourceYours: "Seus sons",
            addSound: "Adicionar som…")
        case .tr: return SoundStrings(
            title: "Sesler",
            caption: "Hangi anların ses çıkaracağını, hangi sesi ve ne kadar yüksek olacağını seçin. %100’ün üzerinde ses güçlendirilir.",
            playSounds: "Sesleri çal",
            sound: "Ses",
            volume: "Ses düzeyi",
            play: "Çal",
            unavailable: "Bu Mac’te yok",
            repeats: "Tekrarla",
            once: "Bir kez",
            timesFormat: "%d kez",
            sourceSystem: "macOS uyarıları",
            sourceTones: "Apple tonları",
            sourceYours: "Sesleriniz",
            addSound: "Ses ekle…")
        case .ru: return SoundStrings(
            title: "Звуки",
            caption: "Выберите, какие моменты озвучиваются, каким звуком и насколько громко. Выше 100% звук усиливается.",
            playSounds: "Воспроизводить звуки",
            sound: "Звук",
            volume: "Громкость",
            play: "Воспроизвести",
            unavailable: "Нет на этом Mac",
            repeats: "Повтор",
            once: "Один раз",
            timesFormat: "%d раза",
            sourceSystem: "Сигналы macOS",
            sourceTones: "Мелодии Apple",
            sourceYours: "Ваши звуки",
            addSound: "Добавить звук…")
        case .es: return SoundStrings(
            title: "Sonidos",
            caption: "Elige qué momentos suenan, con qué sonido y a qué volumen. Por encima del 100%, el sonido se amplifica.",
            playSounds: "Reproducir sonidos",
            sound: "Sonido",
            volume: "Volumen",
            play: "Reproducir",
            unavailable: "No está en este Mac",
            repeats: "Repetir",
            once: "Una vez",
            timesFormat: "%d veces",
            sourceSystem: "Alertas de macOS",
            sourceTones: "Tonos de Apple",
            sourceYours: "Tus sonidos",
            addSound: "Añadir sonido…")
        case .sk: return SoundStrings(
            title: "Zvuky",
            caption: "Vyberte, ktoré chvíle zaznejú, akým zvukom a ako nahlas. Nad 100 % sa zvuk zosilní.",
            playSounds: "Prehrávať zvuky",
            sound: "Zvuk",
            volume: "Hlasitosť",
            play: "Prehrať",
            unavailable: "Nie je v tomto Macu",
            repeats: "Opakovať",
            once: "Raz",
            timesFormat: "%d-krát",
            sourceSystem: "Upozornenia macOS",
            sourceTones: "Tóny Apple",
            sourceYours: "Vaše zvuky",
            addSound: "Pridať zvuk…")
        case .de: return SoundStrings(
            title: "Töne",
            caption: "Wähle, welche Momente einen Ton spielen, welchen und wie laut. Über 100 % wird der Ton verstärkt.",
            playSounds: "Töne abspielen",
            sound: "Ton",
            volume: "Lautstärke",
            play: "Abspielen",
            unavailable: "Nicht auf diesem Mac",
            repeats: "Wiederholen",
            once: "Einmal",
            timesFormat: "%d-mal",
            sourceSystem: "macOS-Hinweistöne",
            sourceTones: "Apple-Töne",
            sourceYours: "Deine Töne",
            addSound: "Ton hinzufügen …")
        case .fr: return SoundStrings(
            title: "Sons",
            caption: "Choisissez quels moments émettent un son, lequel et à quel volume. Au-delà de 100 %, le son est amplifié.",
            playSounds: "Lire les sons",
            sound: "Son",
            volume: "Volume",
            play: "Écouter",
            unavailable: "Absent de ce Mac",
            repeats: "Répéter",
            once: "Une fois",
            timesFormat: "%d fois",
            sourceSystem: "Alertes macOS",
            sourceTones: "Tonalités Apple",
            sourceYours: "Vos sons",
            addSound: "Ajouter un son…")
        case .it: return SoundStrings(
            title: "Suoni",
            caption: "Scegli quali momenti emettono un suono, quale suono e a che volume. Oltre il 100% il suono viene amplificato.",
            playSounds: "Riproduci suoni",
            sound: "Suono",
            volume: "Volume",
            play: "Riproduci",
            unavailable: "Non presente su questo Mac",
            repeats: "Ripeti",
            once: "Una volta",
            timesFormat: "%d volte",
            sourceSystem: "Avvisi di macOS",
            sourceTones: "Toni Apple",
            sourceYours: "I tuoi suoni",
            addSound: "Aggiungi suono…")
        case .ja: return SoundStrings(
            title: "サウンド",
            caption: "どの場面で音を鳴らすか、どの音をどの音量で鳴らすかを選びます。100%を超えると音が増幅されます。",
            playSounds: "サウンドを再生",
            sound: "サウンド",
            volume: "音量",
            play: "再生",
            unavailable: "このMacにはありません",
            repeats: "繰り返し",
            once: "1回",
            timesFormat: "%d回",
            sourceSystem: "macOSの通知音",
            sourceTones: "Appleのトーン",
            sourceYours: "自分のサウンド",
            addSound: "サウンドを追加…")
        case .ko: return SoundStrings(
            title: "사운드",
            caption: "어떤 순간에 소리를 낼지, 어떤 소리를 얼마나 크게 낼지 선택하세요. 100%를 넘으면 소리가 증폭됩니다.",
            playSounds: "사운드 재생",
            sound: "사운드",
            volume: "음량",
            play: "재생",
            unavailable: "이 Mac에 없음",
            repeats: "반복",
            once: "1회",
            timesFormat: "%d회",
            sourceSystem: "macOS 알림음",
            sourceTones: "Apple 톤",
            sourceYours: "내 사운드",
            addSound: "사운드 추가…")
        case .uk: return SoundStrings(
            title: "Звуки",
            caption: "Виберіть, які моменти звучать, яким звуком і наскільки гучно. Понад 100% звук підсилюється.",
            playSounds: "Відтворювати звуки",
            sound: "Звук",
            volume: "Гучність",
            play: "Відтворити",
            unavailable: "Немає на цьому Mac",
            repeats: "Повтор",
            once: "Один раз",
            timesFormat: "%d рази",
            sourceSystem: "Сигнали macOS",
            sourceTones: "Мелодії Apple",
            sourceYours: "Ваші звуки",
            addSound: "Додати звук…")
        case .zhHans: return SoundStrings(
            title: "声音",
            caption: "选择哪些时刻发出声音、用什么声音以及音量多大。超过 100% 时声音会被增强。",
            playSounds: "播放声音",
            sound: "声音",
            volume: "音量",
            play: "播放",
            unavailable: "此 Mac 上没有",
            repeats: "重复",
            once: "一次",
            timesFormat: "%d 次",
            sourceSystem: "macOS 提示音",
            sourceTones: "Apple 铃声",
            sourceYours: "你的声音",
            addSound: "添加声音…")
        case .zhTW: return SoundStrings(
            title: "聲音",
            caption: "選擇哪些時刻發出聲音、使用什麼聲音以及音量大小。超過 100% 時聲音會被增強。",
            playSounds: "播放聲音",
            sound: "聲音",
            volume: "音量",
            play: "播放",
            unavailable: "此 Mac 上沒有",
            repeats: "重複",
            once: "一次",
            timesFormat: "%d 次",
            sourceSystem: "macOS 提示聲",
            sourceTones: "Apple 鈴聲",
            sourceYours: "你的聲音",
            addSound: "加入聲音…")
        case .zhHK: return SoundStrings(
            title: "聲音",
            caption: "選擇哪些時刻發出聲音、用甚麼聲音及音量大小。超過 100% 時聲音會被增強。",
            playSounds: "播放聲音",
            sound: "聲音",
            volume: "音量",
            play: "播放",
            unavailable: "此 Mac 上沒有",
            repeats: "重複",
            once: "一次",
            timesFormat: "%d 次",
            sourceSystem: "macOS 提示聲",
            sourceTones: "Apple 鈴聲",
            sourceYours: "你的聲音",
            addSound: "加入聲音…")
        }
    }
}
