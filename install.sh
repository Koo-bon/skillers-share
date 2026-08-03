#!/usr/bin/env bash
# 스킬러스 공유회 설치.
#
#   bash install.sh          이미 있는 스킬은 건드리지 않는다
#   bash install.sh --force  이미 있어도 백업하고 최신으로 교체한다
#
# 함께 쓰는 스킬 3종은 설치할 때마다 원본 저장소에서 최신을 받아온다.
# 네트워크가 없으면 bundled/ 의 동봉본으로 떨어진다.
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
STAMP="$(date +%Y%m%d-%H%M%S)"
FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

WEBDECK_RAW="https://raw.githubusercontent.com/Koo-bon/webdeck/main"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# ── 1) 공유회-OS 본체
mkdir -p "$DEST/공유회-OS/engine"
cp "$SRC/SKILL.md" "$DEST/공유회-OS/"
cp -R "$SRC/references" "$DEST/공유회-OS/"
cp "$SRC/engine/share-extend.css" "$SRC/engine/share-extend.js" "$DEST/공유회-OS/engine/"

# ── 2) webdeck 덱 엔진 (항상 원본에서, 무수정)
echo "webdeck 엔진 내려받는 중…"
for f in index.html generate_deck.py brief_template.json; do
  curl -fsSL "$WEBDECK_RAW/webdeck/$f" -o "$DEST/공유회-OS/engine/$f"
done
mkdir -p "$DEST/공유회-OS/engine/references"
curl -fsSL "$WEBDECK_RAW/webdeck/references/slide-types.md" \
  -o "$DEST/공유회-OS/engine/engine-slide-types.tmp" \
  && mv "$DEST/공유회-OS/engine/engine-slide-types.tmp" \
        "$DEST/공유회-OS/engine/references/slide-types.md"

# ── 3) 함께 쓰는 스킬 3종
# 원본 tarball 을 받아 최신을 쓰고, 실패하면 동봉본을 쓴다.
echo
echo "함께 쓰는 스킬 확인 중…"

fetch_latest() {  # $1=스킬명 → $TMP/latest/<스킬명> 에 놓이면 0
  local name="$1"
  case "$name" in
    훅카피|크리틱디렉터)
      curl -fsSL "https://github.com/Koo-bon/webdeck/archive/refs/heads/main.tar.gz" \
        -o "$TMP/webdeck.tgz" 2>/dev/null || return 1
      tar xzf "$TMP/webdeck.tgz" -C "$TMP" 2>/dev/null || return 1
      [ -d "$TMP/webdeck-main/$name" ] || return 1
      mkdir -p "$TMP/latest" && cp -R "$TMP/webdeck-main/$name" "$TMP/latest/" ;;
    spec-guard)
      curl -fsSL "https://github.com/Koo-bon/spec-guard/archive/refs/heads/main.tar.gz" \
        -o "$TMP/sg.tgz" 2>/dev/null || return 1
      tar xzf "$TMP/sg.tgz" -C "$TMP" 2>/dev/null || return 1
      [ -f "$TMP/spec-guard-main/SKILL.md" ] || return 1
      mkdir -p "$TMP/latest/spec-guard"
      cp "$TMP/spec-guard-main/SKILL.md" "$TMP/spec-guard-main/RULES"*.md \
         "$TMP/spec-guard-main/"*.sh "$TMP/latest/spec-guard/" 2>/dev/null ;;
  esac
  [ -f "$TMP/latest/$name/SKILL.md" ]
}

for s in 훅카피 크리틱디렉터 spec-guard; do
  if [ -d "$DEST/$s" ] && [ "$FORCE" -eq 0 ]; then
    echo "  · $s — 이미 있음, 그대로 둡니다 (교체하려면 --force)"
    continue
  fi

  if fetch_latest "$s"; then
    from="$TMP/latest/$s"; src_label="원본 최신"
  else
    from="$SRC/bundled/$s";  src_label="동봉본 (네트워크 실패)"
  fi

  if [ -d "$DEST/$s" ]; then
    mv "$DEST/$s" "$DEST/$s.backup-$STAMP"
    echo "  · $s — $src_label 으로 교체 (기존 것은 $s.backup-$STAMP)"
  else
    echo "  · $s — 설치 ($src_label)"
  fi
  rm -rf "$DEST/$s" && cp -R "$from" "$DEST/$s"
done

echo
echo "설치 완료: $DEST"
echo
echo "클로드에서 이렇게 부르세요:  공유회 준비해줘"
echo "나중에 최신으로 올리려면:    bash install.sh --force"
