#!/usr/bin/env bash
# Отправляет 05-telegram-brief.md в Telegram через WorkBK_Bot.
# Запускать ЛОКАЛЬНО на машине Boris — токен лежит только там.
#
#   bash clients/coinspaid/send-to-workbk.sh
#
# Параметры берутся из того же места, что и workbk-start-day:
#   token : /Users/bk/.config/boris-os/workbk.env → WORKBK_TELEGRAM_TOKEN
#   chat  : 2904366 (Boris) — см. config.yaml delivery.telegram.bot_chat_id
set -euo pipefail

ENV_FILE="${WORKBK_ENV_FILE:-/Users/bk/.config/boris-os/workbk.env}"
CHAT_ID="${WORKBK_CHAT_ID:-2904366}"
MSG_FILE="$(dirname "$0")/05-telegram-brief.md"

[ -f "$ENV_FILE" ] || { echo "Нет файла с токеном: $ENV_FILE" >&2; exit 1; }
[ -f "$MSG_FILE" ] || { echo "Нет файла брифа: $MSG_FILE" >&2; exit 1; }

# shellcheck disable=SC1090
TOKEN="$(grep -E '^WORKBK_TELEGRAM_TOKEN=' "$ENV_FILE" | head -1 | cut -d= -f2- | tr -d '"'"'"' ')"
[ -n "$TOKEN" ] || { echo "WORKBK_TELEGRAM_TOKEN не найден в $ENV_FILE" >&2; exit 1; }

# Telegram режет сообщения на 4096 символов — бьём по пустым строкам с запасом.
python3 - "$TOKEN" "$CHAT_ID" "$MSG_FILE" <<'PY'
import sys, urllib.request, urllib.parse, json, time

token, chat_id, path = sys.argv[1], sys.argv[2], sys.argv[3]
text = open(path, encoding="utf-8").read()

MAX = 3800
chunks, cur = [], ""
for para in text.split("\n\n"):
    if len(cur) + len(para) + 2 > MAX:
        if cur:
            chunks.append(cur)
        cur = para
    else:
        cur = f"{cur}\n\n{para}" if cur else para
if cur:
    chunks.append(cur)

for i, chunk in enumerate(chunks, 1):
    data = urllib.parse.urlencode({
        "chat_id": chat_id,
        "text": chunk,
        "parse_mode": "Markdown",
        "disable_web_page_preview": "true",
    }).encode()
    req = urllib.request.Request(
        f"https://api.telegram.org/bot{token}/sendMessage", data=data
    )
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            json.load(resp)
        print(f"отправлено {i}/{len(chunks)}")
    except urllib.error.HTTPError as e:
        # Markdown может не пройти на спецсимволах — повтор без разметки.
        body = e.read().decode(errors="replace")
        print(f"часть {i}: Markdown отклонён ({body[:120]}), шлю без разметки")
        data = urllib.parse.urlencode({
            "chat_id": chat_id, "text": chunk, "disable_web_page_preview": "true",
        }).encode()
        req = urllib.request.Request(
            f"https://api.telegram.org/bot{token}/sendMessage", data=data
        )
        with urllib.request.urlopen(req, timeout=30) as resp:
            json.load(resp)
        print(f"отправлено {i}/{len(chunks)} (plain)")
    time.sleep(0.5)
PY
