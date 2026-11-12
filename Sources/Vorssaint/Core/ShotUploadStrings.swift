// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint

import Foundation

/// Localized strings for the screenshot tool's share links: the upload
/// button, its settings and its confirmations.
struct ShotUploadStrings {
    let button: String
    let title: String
    let caption: String
    let keyLabel: String
    let getKey: String
    let expiryLabel: String
    let never: String
    let hour: String
    let day: String
    let week: String
    let month: String
    let linkCopied: String
    let failed: String
    let needsKey: String
}

extension FeatureStrings {
    static func shotUpload(_ language: AppLanguage) -> ShotUploadStrings {
        switch language {
        case .enUS: return .enUS
        case .ptBR: return .ptBR
        case .tr: return .tr
        case .ru: return .ru
        case .es: return .es
        case .sk: return .sk
        case .de: return .de
        case .fr: return .fr
        case .it: return .it
        case .ja: return .ja
        case .ko: return .ko
        case .zhHans: return .zhHans
        case .zhTW: return .zhTW
        case .zhHK: return .zhHK
        case .uk: return .uk
        }
    }
}

extension ShotUploadStrings {
    static let enUS = ShotUploadStrings(
        button: "Upload and copy link",
        title: "Share links",
        caption: "The upload button (⌘D) sends the screenshot to ImgBB and copies a link anyone can open. It needs your own free ImgBB API key, which stays on this Mac. Without a key nothing is uploaded. Uploads appear in your ImgBB account, where you can delete them.",
        keyLabel: "ImgBB API key",
        getKey: "Get a key",
        expiryLabel: "Links expire",
        never: "Never",
        hour: "After 1 hour",
        day: "After 1 day",
        week: "After 1 week",
        month: "After 30 days",
        linkCopied: "Link copied",
        failed: "Upload failed. The screenshot was copied instead.",
        needsKey: "Add your ImgBB API key in Settings to upload. The screenshot was copied instead."
    )

    static let ptBR = ShotUploadStrings(
        button: "Enviar e copiar o link",
        title: "Links de compartilhamento",
        caption: "O botão de envio (⌘D) manda a captura para o ImgBB e copia um link que qualquer pessoa pode abrir. Ele precisa da sua própria chave de API gratuita do ImgBB, que fica neste Mac. Sem uma chave, nada é enviado. Os envios aparecem na sua conta do ImgBB, onde você pode apagá-los.",
        keyLabel: "Chave de API do ImgBB",
        getKey: "Obter uma chave",
        expiryLabel: "Os links expiram",
        never: "Nunca",
        hour: "Depois de 1 hora",
        day: "Depois de 1 dia",
        week: "Depois de 1 semana",
        month: "Depois de 30 dias",
        linkCopied: "Link copiado",
        failed: "O envio falhou. A captura foi copiada.",
        needsKey: "Adicione sua chave de API do ImgBB nos Ajustes para enviar. A captura foi copiada."
    )

    static let tr = ShotUploadStrings(
        button: "Yükle ve bağlantıyı kopyala",
        title: "Paylaşım bağlantıları",
        caption: "Yükleme düğmesi (⌘D) ekran görüntüsünü ImgBB’ye gönderir ve herkesin açabileceği bir bağlantıyı kopyalar. Bunun için bu Mac’te kalan, size ait ücretsiz bir ImgBB API anahtarı gerekir. Anahtar olmadan hiçbir şey yüklenmez. Yüklemeler ImgBB hesabınızda görünür; oradan silebilirsiniz.",
        keyLabel: "ImgBB API anahtarı",
        getKey: "Anahtar al",
        expiryLabel: "Bağlantıların süresi",
        never: "Hiç dolmaz",
        hour: "1 saat sonra dolar",
        day: "1 gün sonra dolar",
        week: "1 hafta sonra dolar",
        month: "30 gün sonra dolar",
        linkCopied: "Bağlantı kopyalandı",
        failed: "Yükleme başarısız oldu. Ekran görüntüsü kopyalandı.",
        needsKey: "Yüklemek için Ayarlar’a ImgBB API anahtarınızı ekleyin. Ekran görüntüsü kopyalandı."
    )

    static let ru = ShotUploadStrings(
        button: "Загрузить и скопировать ссылку",
        title: "Ссылки для отправки",
        caption: "Кнопка загрузки (⌘D) отправляет снимок в ImgBB и копирует ссылку, которую может открыть любой. Нужен ваш бесплатный ключ API ImgBB; он остаётся на этом Mac. Без ключа ничего не загружается. Загруженные снимки видны в вашей учётной записи ImgBB, где их можно удалить.",
        keyLabel: "Ключ API ImgBB",
        getKey: "Получить ключ",
        expiryLabel: "Срок действия ссылок",
        never: "Бессрочно",
        hour: "1 час",
        day: "1 день",
        week: "1 неделя",
        month: "30 дней",
        linkCopied: "Ссылка скопирована",
        failed: "Не удалось загрузить. Снимок скопирован.",
        needsKey: "Чтобы загружать, добавьте ключ API ImgBB в настройках. Снимок скопирован."
    )

    static let es = ShotUploadStrings(
        button: "Subir y copiar el enlace",
        title: "Enlaces para compartir",
        caption: "El botón de subida (⌘D) envía la captura a ImgBB y copia un enlace que cualquiera puede abrir. Necesita tu propia clave de API gratuita de ImgBB, que se queda en este Mac. Sin una clave no se sube nada. Las subidas aparecen en tu cuenta de ImgBB, donde puedes borrarlas.",
        keyLabel: "Clave de API de ImgBB",
        getKey: "Obtener una clave",
        expiryLabel: "Los enlaces caducan",
        never: "Nunca",
        hour: "Después de 1 hora",
        day: "Después de 1 día",
        week: "Después de 1 semana",
        month: "Después de 30 días",
        linkCopied: "Enlace copiado",
        failed: "La subida ha fallado. Se ha copiado la captura.",
        needsKey: "Añade tu clave de API de ImgBB en Ajustes para subir. Se ha copiado la captura."
    )

    static let sk = ShotUploadStrings(
        button: "Nahrať a skopírovať odkaz",
        title: "Odkazy na zdieľanie",
        caption: "Tlačidlo nahrania (⌘D) odošle snímku do služby ImgBB a skopíruje odkaz, ktorý môže otvoriť ktokoľvek. Potrebuje váš vlastný bezplatný kľúč API služby ImgBB, ktorý zostáva v tomto Macu. Bez kľúča sa nič nenahrá. Nahrané snímky sa zobrazia vo vašom účte ImgBB, kde ich môžete vymazať.",
        keyLabel: "Kľúč API služby ImgBB",
        getKey: "Získať kľúč",
        expiryLabel: "Platnosť odkazov",
        never: "Bez obmedzenia",
        hour: "1 hodina",
        day: "1 deň",
        week: "1 týždeň",
        month: "30 dní",
        linkCopied: "Odkaz skopírovaný",
        failed: "Nahranie zlyhalo. Snímka bola skopírovaná.",
        needsKey: "Ak chcete nahrávať, pridajte v Nastaveniach kľúč API služby ImgBB. Snímka bola skopírovaná."
    )

    static let de = ShotUploadStrings(
        button: "Hochladen und Link kopieren",
        title: "Links zum Teilen",
        caption: "Die Hochladen-Taste (⌘D) sendet das Bildschirmfoto an ImgBB und kopiert einen Link, den jeder öffnen kann. Dafür ist dein eigener kostenloser ImgBB-API-Schlüssel nötig, der auf diesem Mac bleibt. Ohne Schlüssel wird nichts hochgeladen. Hochgeladene Bilder erscheinen in deinem ImgBB-Account, wo du sie löschen kannst.",
        keyLabel: "ImgBB-API-Schlüssel",
        getKey: "Schlüssel holen",
        expiryLabel: "Links laufen ab",
        never: "Nie",
        hour: "Nach 1 Stunde",
        day: "Nach 1 Tag",
        week: "Nach 1 Woche",
        month: "Nach 30 Tagen",
        linkCopied: "Link kopiert",
        failed: "Hochladen fehlgeschlagen. Das Bildschirmfoto wurde kopiert.",
        needsKey: "Trage zum Hochladen deinen ImgBB-API-Schlüssel in den Einstellungen ein. Das Bildschirmfoto wurde kopiert."
    )

    static let fr = ShotUploadStrings(
        button: "Téléverser et copier le lien",
        title: "Liens de partage",
        caption: "Le bouton de téléversement (⌘D) envoie la capture à ImgBB et copie un lien que tout le monde peut ouvrir. Il faut votre propre clé d’API ImgBB gratuite, qui reste sur ce Mac. Sans clé, rien n’est téléversé. Les envois apparaissent dans votre compte ImgBB, où vous pouvez les supprimer.",
        keyLabel: "Clé d’API ImgBB",
        getKey: "Obtenir une clé",
        expiryLabel: "Expiration des liens",
        never: "Jamais",
        hour: "Après 1 heure",
        day: "Après 1 jour",
        week: "Après 1 semaine",
        month: "Après 30 jours",
        linkCopied: "Lien copié",
        failed: "Échec du téléversement. La capture a été copiée.",
        needsKey: "Ajoutez votre clé d’API ImgBB dans les réglages pour téléverser. La capture a été copiée."
    )

    static let it = ShotUploadStrings(
        button: "Carica e copia il link",
        title: "Link di condivisione",
        caption: "Il pulsante di caricamento (⌘D) invia l’istantanea a ImgBB e copia un link che chiunque può aprire. Serve la tua chiave API gratuita di ImgBB, che resta su questo Mac. Senza una chiave non viene caricato nulla. I caricamenti compaiono nel tuo account ImgBB, dove puoi eliminarli.",
        keyLabel: "Chiave API di ImgBB",
        getKey: "Ottieni una chiave",
        expiryLabel: "Scadenza dei link",
        never: "Mai",
        hour: "Dopo 1 ora",
        day: "Dopo 1 giorno",
        week: "Dopo 1 settimana",
        month: "Dopo 30 giorni",
        linkCopied: "Link copiato",
        failed: "Caricamento non riuscito. L’istantanea è stata copiata.",
        needsKey: "Aggiungi la tua chiave API di ImgBB nelle Impostazioni per caricare. L’istantanea è stata copiata."
    )

    static let ja = ShotUploadStrings(
        button: "アップロードしてリンクをコピー",
        title: "共有リンク",
        caption: "アップロードボタン（⌘D）はスクリーンショットをImgBBに送信し、誰でも開けるリンクをコピーします。ご自身の無料のImgBB APIキーが必要で、キーはこのMacに保存されます。キーがなければ何もアップロードされません。アップロードした画像はImgBBアカウントに表示され、そこで削除できます。",
        keyLabel: "ImgBB APIキー",
        getKey: "キーを取得",
        expiryLabel: "リンクの有効期限",
        never: "なし",
        hour: "1時間後",
        day: "1日後",
        week: "1週間後",
        month: "30日後",
        linkCopied: "リンクをコピーしました",
        failed: "アップロードできませんでした。スクリーンショットをコピーしました。",
        needsKey: "アップロードするには、設定でImgBB APIキーを追加してください。スクリーンショットをコピーしました。"
    )

    static let ko = ShotUploadStrings(
        button: "업로드하고 링크 복사",
        title: "공유 링크",
        caption: "업로드 버튼(⌘D)은 스크린샷을 ImgBB로 보내고 누구나 열 수 있는 링크를 복사합니다. 본인의 무료 ImgBB API 키가 필요하며, 키는 이 Mac에 보관됩니다. 키가 없으면 아무것도 업로드되지 않습니다. 업로드한 이미지는 ImgBB 계정에 표시되며 그곳에서 삭제할 수 있습니다.",
        keyLabel: "ImgBB API 키",
        getKey: "키 받기",
        expiryLabel: "링크 만료",
        never: "만료 안 함",
        hour: "1시간 후",
        day: "1일 후",
        week: "1주 후",
        month: "30일 후",
        linkCopied: "링크를 복사했습니다",
        failed: "업로드하지 못했습니다. 스크린샷을 복사했습니다.",
        needsKey: "업로드하려면 설정에서 ImgBB API 키를 추가하세요. 스크린샷을 복사했습니다."
    )

    static let zhHans = ShotUploadStrings(
        button: "上传并拷贝链接",
        title: "共享链接",
        caption: "上传按钮（⌘D）会将截屏发送到 ImgBB，并拷贝一个任何人都能打开的链接。这需要你自己的免费 ImgBB API 密钥，密钥保存在这台 Mac 上。没有密钥就不会上传任何内容。上传的图片会出现在你的 ImgBB 账户中，可以在那里删除。",
        keyLabel: "ImgBB API 密钥",
        getKey: "获取密钥",
        expiryLabel: "链接有效期",
        never: "永不过期",
        hour: "1 小时后",
        day: "1 天后",
        week: "1 周后",
        month: "30 天后",
        linkCopied: "已拷贝链接",
        failed: "上传失败，已改为拷贝截屏。",
        needsKey: "要上传，请在设置中添加 ImgBB API 密钥。已改为拷贝截屏。"
    )

    static let zhTW = ShotUploadStrings(
        button: "上傳並拷貝連結",
        title: "分享連結",
        caption: "上傳按鈕（⌘D）會將截圖傳送到 ImgBB，並拷貝一個任何人都能打開的連結。這需要你自己的免費 ImgBB API 金鑰，金鑰會保存在這部 Mac 上。沒有金鑰就不會上傳任何內容。上傳的圖片會出現在你的 ImgBB 帳號中，可以在那裡刪除。",
        keyLabel: "ImgBB API 金鑰",
        getKey: "取得金鑰",
        expiryLabel: "連結有效期限",
        never: "永不過期",
        hour: "1 小時後",
        day: "1 天後",
        week: "1 週後",
        month: "30 天後",
        linkCopied: "已拷貝連結",
        failed: "上傳失敗，已改為拷貝截圖。",
        needsKey: "若要上傳，請在設定中加入 ImgBB API 金鑰。已改為拷貝截圖。"
    )

    static let zhHK = ShotUploadStrings(
        button: "上載並拷貝連結",
        title: "分享連結",
        caption: "上載按鈕（⌘D）會將截圖傳送到 ImgBB，並拷貝一個任何人都能打開的連結。這需要你自己的免費 ImgBB API 密鑰，密鑰會儲存在這部 Mac 上。沒有密鑰就不會上載任何內容。上載的圖片會出現在你的 ImgBB 帳户中，可以在那裏刪除。",
        keyLabel: "ImgBB API 密鑰",
        getKey: "取得密鑰",
        expiryLabel: "連結有效期限",
        never: "永不過期",
        hour: "1 小時後",
        day: "1 日後",
        week: "1 星期後",
        month: "30 日後",
        linkCopied: "已拷貝連結",
        failed: "上載失敗，已改為拷貝截圖。",
        needsKey: "如要上載，請在設定中加入 ImgBB API 密鑰。已改為拷貝截圖。"
    )

    static let uk = ShotUploadStrings(
        button: "Вивантажити й скопіювати посилання",
        title: "Посилання для поширення",
        caption: "Кнопка вивантаження (⌘D) надсилає знімок до ImgBB і копіює посилання, яке може відкрити будь-хто. Потрібен ваш власний безплатний ключ API ImgBB; він залишається на цьому Mac. Без ключа нічого не вивантажується. Вивантажені знімки видно у вашому обліковому записі ImgBB, де їх можна видалити.",
        keyLabel: "Ключ API ImgBB",
        getKey: "Отримати ключ",
        expiryLabel: "Термін дії посилань",
        never: "Безстроково",
        hour: "1 година",
        day: "1 день",
        week: "1 тиждень",
        month: "30 днів",
        linkCopied: "Посилання скопійовано",
        failed: "Не вдалося вивантажити. Знімок скопійовано.",
        needsKey: "Щоб вивантажувати, додайте ключ API ImgBB у налаштуваннях. Знімок скопійовано."
    )
}
