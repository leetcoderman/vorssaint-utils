// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

extension FeatureStrings {
    /// The AI agents section of the Sounds page.
    static func agentSounds(_ language: AppLanguage) -> SoundGroupStrings {
        switch language {
        case .enUS: return SoundGroupStrings(
            title: "AI agents",
            note: "Agent sounds play while the AI page of the Dynamic Island is on.",
            moments: [
                .agentFinished: SoundMoment(title: "Agent finished",
                                            caption: "When an agent ends its turn and its work waits for you."),
                .agentStarted: SoundMoment(title: "Agent started",
                                           caption: "When an agent starts working."),
            ])
        case .ptBR: return SoundGroupStrings(
            title: "Agentes de IA",
            note: "Os sons dos agentes tocam enquanto a página de IA da Dynamic Island está ativada.",
            moments: [
                .agentFinished: SoundMoment(title: "Agente terminou",
                                            caption: "Quando um agente encerra a vez e o trabalho espera por você."),
                .agentStarted: SoundMoment(title: "Agente começou",
                                           caption: "Quando um agente começa a trabalhar."),
            ])
        case .tr: return SoundGroupStrings(
            title: "Yapay zekâ ajanları",
            note: "Ajan sesleri, Dynamic Island’ın yapay zekâ sayfası açıkken çalar.",
            moments: [
                .agentFinished: SoundMoment(title: "Ajan bitirdi",
                                            caption: "Bir ajan sırasını bitirdiğinde ve işi sizi beklediğinde."),
                .agentStarted: SoundMoment(title: "Ajan başladı",
                                           caption: "Bir ajan çalışmaya başladığında."),
            ])
        case .ru: return SoundGroupStrings(
            title: "ИИ-агенты",
            note: "Звуки агентов воспроизводятся, пока включена страница ИИ в Dynamic Island.",
            moments: [
                .agentFinished: SoundMoment(title: "Агент закончил",
                                            caption: "Когда агент завершает ход и работа ждёт вас."),
                .agentStarted: SoundMoment(title: "Агент начал",
                                           caption: "Когда агент начинает работу."),
            ])
        case .es: return SoundGroupStrings(
            title: "Agentes de IA",
            note: "Los sonidos de los agentes suenan mientras la página de IA de la Dynamic Island está activada.",
            moments: [
                .agentFinished: SoundMoment(title: "Agente terminado",
                                            caption: "Cuando un agente termina su turno y su trabajo te espera."),
                .agentStarted: SoundMoment(title: "Agente iniciado",
                                           caption: "Cuando un agente empieza a trabajar."),
            ])
        case .sk: return SoundGroupStrings(
            title: "AI agenti",
            note: "Zvuky agentov znejú, kým je zapnutá stránka AI v Dynamic Island.",
            moments: [
                .agentFinished: SoundMoment(title: "Agent dokončil",
                                            caption: "Keď agent ukončí svoj ťah a práca na vás čaká."),
                .agentStarted: SoundMoment(title: "Agent začal",
                                           caption: "Keď agent začne pracovať."),
            ])
        case .de: return SoundGroupStrings(
            title: "KI-Agenten",
            note: "Agententöne spielen, solange die KI-Seite der Dynamic Island aktiviert ist.",
            moments: [
                .agentFinished: SoundMoment(title: "Agent fertig",
                                            caption: "Wenn ein Agent seinen Zug beendet und die Arbeit auf dich wartet."),
                .agentStarted: SoundMoment(title: "Agent gestartet",
                                           caption: "Wenn ein Agent zu arbeiten beginnt."),
            ])
        case .fr: return SoundGroupStrings(
            title: "Agents IA",
            note: "Les sons des agents sont lus tant que la page IA de la Dynamic Island est activée.",
            moments: [
                .agentFinished: SoundMoment(title: "Agent terminé",
                                            caption: "Quand un agent termine son tour et que son travail vous attend."),
                .agentStarted: SoundMoment(title: "Agent démarré",
                                           caption: "Quand un agent commence à travailler."),
            ])
        case .it: return SoundGroupStrings(
            title: "Agenti IA",
            note: "I suoni degli agenti si sentono mentre la pagina IA della Dynamic Island è attiva.",
            moments: [
                .agentFinished: SoundMoment(title: "Agente terminato",
                                            caption: "Quando un agente termina il suo turno e il lavoro ti aspetta."),
                .agentStarted: SoundMoment(title: "Agente avviato",
                                           caption: "Quando un agente inizia a lavorare."),
            ])
        case .ja: return SoundGroupStrings(
            title: "AIエージェント",
            note: "エージェントのサウンドは、Dynamic IslandのAIページがオンのときに鳴ります。",
            moments: [
                .agentFinished: SoundMoment(title: "エージェントが完了",
                                            caption: "エージェントがターンを終え、作業があなたを待っているとき。"),
                .agentStarted: SoundMoment(title: "エージェントが開始",
                                           caption: "エージェントが作業を始めたとき。"),
            ])
        case .ko: return SoundGroupStrings(
            title: "AI 에이전트",
            note: "에이전트 사운드는 Dynamic Island의 AI 페이지가 켜져 있을 때 재생됩니다.",
            moments: [
                .agentFinished: SoundMoment(title: "에이전트 완료",
                                            caption: "에이전트가 차례를 마치고 작업이 사용자를 기다릴 때."),
                .agentStarted: SoundMoment(title: "에이전트 시작",
                                           caption: "에이전트가 작업을 시작할 때."),
            ])
        case .uk: return SoundGroupStrings(
            title: "ШІ-агенти",
            note: "Звуки агентів лунають, поки ввімкнено сторінку ШІ в Dynamic Island.",
            moments: [
                .agentFinished: SoundMoment(title: "Агент завершив",
                                            caption: "Коли агент завершує хід і робота чекає на вас."),
                .agentStarted: SoundMoment(title: "Агент почав",
                                           caption: "Коли агент починає роботу."),
            ])
        case .zhHans: return SoundGroupStrings(
            title: "AI 智能体",
            note: "智能体声音会在 Dynamic Island 的 AI 页面开启时播放。",
            moments: [
                .agentFinished: SoundMoment(title: "智能体完成",
                                            caption: "当智能体结束本轮工作、等待你查看时。"),
                .agentStarted: SoundMoment(title: "智能体开始",
                                           caption: "当智能体开始工作时。"),
            ])
        case .zhTW: return SoundGroupStrings(
            title: "AI 代理",
            note: "代理的聲音會在 Dynamic Island 的 AI 頁面開啟時播放。",
            moments: [
                .agentFinished: SoundMoment(title: "代理已完成",
                                            caption: "當代理結束這一輪工作、等待你查看時。"),
                .agentStarted: SoundMoment(title: "代理已開始",
                                           caption: "當代理開始工作時。"),
            ])
        case .zhHK: return SoundGroupStrings(
            title: "AI 代理",
            note: "代理的聲音會在 Dynamic Island 的 AI 頁面開啟時播放。",
            moments: [
                .agentFinished: SoundMoment(title: "代理已完成",
                                            caption: "當代理完成這一輪工作、等待你查看時。"),
                .agentStarted: SoundMoment(title: "代理已開始",
                                           caption: "當代理開始工作時。"),
            ])
        }
    }
}
