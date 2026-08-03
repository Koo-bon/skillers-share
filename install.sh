#!/usr/bin/env bash
# 스킬러스 공유회 설치.
#   1) 공유회-OS 본체를 ~/.claude/skills/ 에 넣는다
#   2) webdeck 덱 엔진을 내려받는다 (원본 무수정)
#   3) 함께 쓰는 스킬 3종(훅카피·크리틱디렉터·spec-guard)을 같이 설치한다
#      — 이미 있으면 덮어쓰기 전에 백업한다
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
RAW="https://raw.githubusercontent.com/Koo-bon/webdeck/main/webdeck"
STAMP="$(date +%Y%m%d-%H%M%S)"

# 1) 본체
mkdir -p "$DEST/공유회-OS/engine"
cp "$SRC/SKILL.md" "$DEST/공유회-OS/"
cp -R "$SRC/references" "$DEST/공유회-OS/"
cp "$SRC/engine/share-extend.css" "$SRC/engine/share-extend.js" "$DEST/공유회-OS/engine/"

# 2) webdeck 엔진 — 원본을 그대로 받는다. 확장은 share-extend.* 에만 있다.
echo "webdeck 엔진 내려받는 중…"
for f in index.html generate_deck.py brief_template.json; do
  curl -fsSL "$RAW/$f" -o "$DEST/공유회-OS/engine/$f"
done
mkdir -p "$DEST/공유회-OS/engine/references"
curl -fsSL "$RAW/references/slide-types.md" \
  -o "$DEST/공유회-OS/engine/references/slide-types.md"

# 3) 함께 쓰는 스킬 3종
echo
echo "함께 쓰는 스킬 설치 중…"
for s in 훅카피 크리틱디렉터 spec-guard; do
  if [ -d "$DEST/$s" ]; then
    mv "$DEST/$s" "$DEST/$s.backup-$STAMP"
    echo "  · $s — 기존 것을 $s.backup-$STAMP 로 백업하고 교체"
  else
    echo "  · $s — 설치"
  fi
  cp -R "$SRC/bundled/$s" "$DEST/$s"
done

echo
echo "설치 완료: $DEST"
echo "  공유회-OS · 훅카피 · 크리틱디렉터 · spec-guard"
echo
echo "클로드에서 이렇게 부르세요:  공유회 준비해줘"
