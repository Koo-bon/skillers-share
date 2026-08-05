#!/usr/bin/env bash
# claude.ai(웹·데스크톱 앱·폰) 업로드용 self-contained 스킬 패키지를 만든다.
# 터미널의 install.sh 는 ~/.claude/skills 에만 넣어서 claude.ai엔 스킬이 안 뜬다.
# 이 스크립트는 엔진(webdeck 포함)까지 통째로 담은 폴더 + zip 을 dist/ 에 만든다 → claude.ai에 업로드.
#
#   bash make-cloud-package.sh
#
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
DIST="$HERE/dist"
PKG="$DIST/공유회-OS"

echo "1/4  엔진 조립 (install.sh 를 임시 폴더에 실행 — webdeck 최신 포함)…"
TMP="$(mktemp -d)"
CLAUDE_SKILLS_DIR="$TMP" bash "$HERE/install.sh" >/dev/null 2>&1
[ -f "$TMP/공유회-OS/engine/generate_deck.py" ] || { echo "엔진 조립 실패 — 네트워크 확인"; exit 1; }

echo "2/4  패키지 폴더 구성…"
rm -rf "$PKG"; mkdir -p "$PKG"
# 조립된 self-contained 스킬 (SKILL.md + references + engine[webdeck 포함])
cp -R "$TMP/공유회-OS/." "$PKG/"
# 부르는 스킬 3종을 패키지 안에 함께 담는다 (claude.ai는 한 폴더 = 한 스킬이라 형제 호출이 없을 수 있음)
mkdir -p "$PKG/bundled"
cp -R "$HERE/bundled/." "$PKG/bundled/"

echo "3/4  업로드 안내 파일 넣기…"
cat > "$PKG/업로드-방법.txt" <<'TXT'
공유회-OS — claude.ai 업로드용 패키지

■ 올리는 곳
  claude.ai 로그인 → Settings(설정) → Capabilities/Skills(기능·스킬) → 스킬 업로드
  이 폴더(또는 같은 이름 zip)를 통째로 올린다. 데스크톱 앱·폰에서도 같은 계정이면 자동으로 뜬다.

■ 부르는 법
  "공유회 준비해줘"  (터미널과 동일)

■ 웹·앱에서 달라지는 것 (딱 2개 — 산출물 품질은 동일)
  · 대화 기록 자동 스캔 없음 → 발표 주제를 직접 알려주면 됨
  · 인터넷 링크 자동 배포 없음 → 덱이 HTML 파일(또는 Artifact)로 나옴, 그걸 공유
  나머지(질문·제목·목차·덱 디자인·발표 대본·검수)는 터미널과 같게 나온다.

■ 부르는 스킬(훅카피·크리틱디렉터·spec-guard)은 이 폴더 bundled/ 안에 함께 들어있다.
TXT

echo "4/4  zip 만들기…"
( cd "$DIST" && rm -f "공유회-OS-claude.ai.zip" && zip -qr "공유회-OS-claude.ai.zip" "공유회-OS" )
rm -rf "$TMP"

echo
echo "완료:"
echo "  폴더  $PKG"
echo "  zip   $DIST/공유회-OS-claude.ai.zip"
echo "→ 이 zip 을 claude.ai 설정의 스킬 업로드에 올리세요 (웹·데스크톱 앱·폰 공용)."
