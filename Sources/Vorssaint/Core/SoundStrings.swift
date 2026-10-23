// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// The Sounds page in Settings.
struct SoundStrings {
    let title: String
    let caption: String
    let playSounds: String
    let agentsTitle: String
    /// Agents are heard only while the island's AI page reads them.
    let agentsOff: String
    let finished: String
    let finishedCaption: String
    let started: String
    let startedCaption: String
    let sound: String
    let volume: String
    let play: String
    let unavailable: String
}

extension FeatureStrings {
    static func sounds(_ language: AppLanguage) -> SoundStrings {
        switch language {
        case .enUS: return SoundStrings(
            title: "Sounds",
            caption: "Choose which moments make a sound, which sound and how loud.",
            playSounds: "Play sounds",
            agentsTitle: "AI agents",
            agentsOff: "Agent sounds play while the AI page of the Dynamic Island is on.",
            finished: "Agent finished",
            finishedCaption: "When an agent ends its turn and its work waits for you.",
            started: "Agent started",
            startedCaption: "When an agent starts working. A soft tick by default.",
            sound: "Sound",
            volume: "Volume",
            play: "Play",
            unavailable: "Not on this Mac")
        case .ptBR: return SoundStrings(
            title: "Sons",
            caption: "Escolha quais momentos tocam um som, qual som e com que volume.",
            playSounds: "Tocar sons",
            agentsTitle: "Agentes de IA",
            agentsOff: "Os sons dos agentes tocam enquanto a página de IA da Dynamic Island está ativada.",
            finished: "Agente terminou",
            finishedCaption: "Quando um agente encerra a vez e o trabalho espera por você.",
            started: "Agente começou",
            startedCaption: "Quando um agente começa a trabalhar. Um toque suave por padrão.",
            sound: "Som",
            volume: "Volume",
            play: "Tocar",
            unavailable: "Não está neste Mac")
        case .tr: return SoundStrings(
            title: "Sesler",
            caption: "Hangi anların ses çıkaracağını, hangi sesi ve ne kadar yüksek olacağını seçin.",
            playSounds: "Sesleri çal",
            agentsTitle: "Yapay zekâ ajanları",
            agentsOff: "Ajan sesleri, Dynamic Island’ın yapay zekâ sayfası açıkken çalar.",
            finished: "Ajan bitirdi",
            finishedCaption: "Bir ajan sırasını bitirdiğinde ve işi sizi beklediğinde.",
            started: "Ajan başladı",
            startedCaption: "Bir ajan çalışmaya başladığında. Varsayılan olarak hafif bir tık.",
            sound: "Ses",
            volume: "Ses düzeyi",
            play: "Çal",
            unavailable: "Bu Mac’te yok")
        case .ru: return SoundStrings(
            title: "Звуки",
            caption: "Выберите, какие моменты озвучиваются, каким звуком и насколько громко.",
            playSounds: "Воспроизводить звуки",
            agentsTitle: "ИИ-агенты",
            agentsOff: "Звуки агентов воспроизводятся, пока включена страница ИИ в Dynamic Island.",
            finished: "Агент закончил",
            finishedCaption: "Когда агент завершает ход и работа ждёт вас.",
            started: "Агент начал",
            startedCaption: "Когда агент начинает работу. По умолчанию звучит тихий щелчок.",
            sound: "Звук",
            volume: "Громкость",
            play: "Воспроизвести",
            unavailable: "Нет на этом Mac")
        case .es: return SoundStrings(
            title: "Sonidos",
            caption: "Elige qué momentos suenan, con qué sonido y a qué volumen.",
            playSounds: "Reproducir sonidos",
            agentsTitle: "Agentes de IA",
            agentsOff: "Los sonidos de los agentes suenan mientras la página de IA de la Dynamic Island está activada.",
            finished: "Agente terminado",
            finishedCaption: "Cuando un agente termina su turno y su trabajo te espera.",
            started: "Agente iniciado",
            startedCaption: "Cuando un agente empieza a trabajar. Un toque suave por omisión.",
            sound: "Sonido",
            volume: "Volumen",
            play: "Reproducir",
            unavailable: "No está en este Mac")
        case .sk: return SoundStrings(
            title: "Zvuky",
            caption: "Vyberte, ktoré chvíle zaznejú, akým zvukom a ako nahlas.",
            playSounds: "Prehrávať zvuky",
            agentsTitle: "AI agenti",
            agentsOff: "Zvuky agentov znejú, kým je zapnutá stránka AI v Dynamic Island.",
            finished: "Agent dokončil",
            finishedCaption: "Keď agent ukončí svoj ťah a práca na vás čaká.",
            started: "Agent začal",
            startedCaption: "Keď agent začne pracovať. Predvolene jemné ťuknutie.",
            sound: "Zvuk",
            volume: "Hlasitosť",
            play: "Prehrať",
            unavailable: "Nie je v tomto Macu")
        case .de: return SoundStrings(
            title: "Töne",
            caption: "Wähle, welche Momente einen Ton spielen, welchen und wie laut.",
            playSounds: "Töne abspielen",
            agentsTitle: "KI-Agenten",
            agentsOff: "Agententöne spielen, solange die KI-Seite der Dynamic Island aktiviert ist.",
            finished: "Agent fertig",
            finishedCaption: "Wenn ein Agent seinen Zug beendet und die Arbeit auf dich wartet.",
            started: "Agent gestartet",
            startedCaption: "Wenn ein Agent zu arbeiten beginnt. Standardmäßig ein leises Ticken.",
            sound: "Ton",
            volume: "Lautstärke",
            play: "Abspielen",
            unavailable: "Nicht auf diesem Mac")
        case .fr: return SoundStrings(
            title: "Sons",
            caption: "Choisissez quels moments émettent un son, lequel et à quel volume.",
            playSounds: "Lire les sons",
            agentsTitle: "Agents IA",
            agentsOff: "Les sons des agents sont lus tant que la page IA de la Dynamic Island est activée.",
            finished: "Agent terminé",
            finishedCaption: "Quand un agent termine son tour et que son travail vous attend.",
            started: "Agent démarré",
            startedCaption: "Quand un agent commence à travailler. Un léger tic par défaut.",
            sound: "Son",
            volume: "Volume",
            play: "Écouter",
            unavailable: "Absent de ce Mac")
        case .it: return SoundStrings(
            title: "Suoni",
            caption: "Scegli quali momenti emettono un suono, quale suono e a che volume.",
            playSounds: "Riproduci suoni",
            agentsTitle: "Agenti IA",
            agentsOff: "I suoni degli agenti si sentono mentre la pagina IA della Dynamic Island è attiva.",
            finished: "Agente terminato",
            finishedCaption: "Quando un agente termina il suo turno e il lavoro ti aspetta.",
            started: "Agente avviato",
            startedCaption: "Quando un agente inizia a lavorare. Un tocco leggero per impostazione predefinita.",
            sound: "Suono",
            volume: "Volume",
            play: "Riproduci",
            unavailable: "Non presente su questo Mac")
        case .ja: return SoundStrings(
            title: "サウンド",
            caption: "どの場面で音を鳴らすか、どの音をどの音量で鳴らすかを選びます。",
            playSounds: "サウンドを再生",
            agentsTitle: "AIエージェント",
            agentsOff: "エージェントのサウンドは、Dynamic IslandのAIページがオンのときに鳴ります。",
            finished: "エージェントが完了",
            finishedCaption: "エージェントがターンを終え、作業があなたを待っているとき。",
            started: "エージェントが開始",
            startedCaption: "エージェントが作業を始めたとき。デフォルトは控えめな音です。",
            sound: "サウンド",
            volume: "音量",
            play: "再生",
            unavailable: "このMacにはありません")
        case .ko: return SoundStrings(
            title: "사운드",
            caption: "어떤 순간에 소리를 낼지, 어떤 소리를 얼마나 크게 낼지 선택하세요.",
            playSounds: "사운드 재생",
            agentsTitle: "AI 에이전트",
            agentsOff: "에이전트 사운드는 Dynamic Island의 AI 페이지가 켜져 있을 때 재생됩니다.",
            finished: "에이전트 완료",
            finishedCaption: "에이전트가 차례를 마치고 작업이 사용자를 기다릴 때.",
            started: "에이전트 시작",
            startedCaption: "에이전트가 작업을 시작할 때. 기본값은 부드러운 소리입니다.",
            sound: "사운드",
            volume: "음량",
            play: "재생",
            unavailable: "이 Mac에 없음")
        case .uk: return SoundStrings(
            title: "Звуки",
            caption: "Виберіть, які моменти звучать, яким звуком і наскільки гучно.",
            playSounds: "Відтворювати звуки",
            agentsTitle: "ШІ-агенти",
            agentsOff: "Звуки агентів лунають, поки ввімкнено сторінку ШІ в Dynamic Island.",
            finished: "Агент завершив",
            finishedCaption: "Коли агент завершує хід і робота чекає на вас.",
            started: "Агент почав",
            startedCaption: "Коли агент починає роботу. Типово лунає тихе клацання.",
            sound: "Звук",
            volume: "Гучність",
            play: "Відтворити",
            unavailable: "Немає на цьому Mac")
        case .zhHans: return SoundStrings(
            title: "声音",
            caption: "选择哪些时刻发出声音、用什么声音以及音量多大。",
            playSounds: "播放声音",
            agentsTitle: "AI 智能体",
            agentsOff: "智能体声音会在 Dynamic Island 的 AI 页面开启时播放。",
            finished: "智能体完成",
            finishedCaption: "当智能体结束本轮工作、等待你查看时。",
            started: "智能体开始",
            startedCaption: "当智能体开始工作时。默认是轻柔的提示音。",
            sound: "声音",
            volume: "音量",
            play: "播放",
            unavailable: "此 Mac 上没有")
        case .zhTW: return SoundStrings(
            title: "聲音",
            caption: "選擇哪些時刻發出聲音、使用什麼聲音以及音量大小。",
            playSounds: "播放聲音",
            agentsTitle: "AI 代理",
            agentsOff: "代理的聲音會在 Dynamic Island 的 AI 頁面開啟時播放。",
            finished: "代理已完成",
            finishedCaption: "當代理結束這一輪工作、等待你查看時。",
            started: "代理已開始",
            startedCaption: "當代理開始工作時。預設為輕柔的提示音。",
            sound: "聲音",
            volume: "音量",
            play: "播放",
            unavailable: "此 Mac 上沒有")
        case .zhHK: return SoundStrings(
            title: "聲音",
            caption: "選擇哪些時刻發出聲音、用甚麼聲音及音量大小。",
            playSounds: "播放聲音",
            agentsTitle: "AI 代理",
            agentsOff: "代理的聲音會在 Dynamic Island 的 AI 頁面開啟時播放。",
            finished: "代理已完成",
            finishedCaption: "當代理完成這一輪工作、等待你查看時。",
            started: "代理已開始",
            startedCaption: "當代理開始工作時。預設為輕柔的提示音。",
            sound: "聲音",
            volume: "音量",
            play: "播放",
            unavailable: "此 Mac 上沒有")
        }
    }
}
