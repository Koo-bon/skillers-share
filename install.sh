#!/usr/bin/env bash
# 공유회-OS 설치: ~/.claude/skills/ 에 스킬을 넣고 webdeck 엔진을 내려받는다.
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
RAW="https://raw.githubusercontent.com/Koo-bon/webdeck/main/webdeck"

mkdir -p "$DEST/공유회-OS/engine"
cp "$SRC/SKILL.md" "$DEST/공유회-OS/"
cp -R "$SRC/references" "$DEST/공유회-OS/"
cp "$SRC/engine/share-extend.css" "$SRC/engine/share-extend.js" "$DEST/공유회-OS/engine/"

echo "webdeck 엔진 내려받는 중…"
for f in index.html generate_deck.py brief_template.json; do
  curl -fsSL "$RAW/$f" -o "$DEST/공유회-OS/engine/$f"
done
mkdir -p "$DEST/공유회-OS/engine/references"
curl -fsSL "$RAW/references/slide-types.md" \
  -o "$DEST/공유회-OS/engine/references/slide-types.md"

echo
echo "설치 완료: $DEST/공유회-OS"
echo
echo "함께 필요한 스킬 (없으면 설치하세요):"
echo "  훅카피 · 크리틱디렉터  →  https://github.com/Koo-bon/webdeck"
echo "  spec-guard            →  https://github.com/Koo-bon/spec-guard"
