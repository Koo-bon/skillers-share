# 🔁 skillers-share 다른 컴퓨터에서 이어가기

> 다 GitHub에 있음. 새 컴퓨터는 **클론만** 하면 됨. 새 Claude 세션에 이 파일 붙여넣고 **"skillers-share 이어서 작업하자"** 하면 이어감.

## 한 줄
`skillers-share` = **공유회-OS** 스킬. 1시간 공유회 발표를 주제 스캔 → 질문3 → 제목 → 목차 → 웹덱 → 스크립트 → 검수까지 자동으로 만든다.

## 레포 2개 (여기 다 있음)
| 레포 | 뭐냐 |
|---|---|
| **github.com/Koo-bon/skillers-share** | 이 스킬 본체 (SKILL.md·themes·표지 시안·install.sh) |
| **github.com/Koo-bon/webdeck** | 덱 엔진 — `install.sh`가 받아옴. 슬라이드 종류가 여기 있음 |

## 다른 컴퓨터에서 (2단계)
```bash
# 1) 스킬 받기 (내 컴퓨터에 설치)
git clone https://github.com/Koo-bon/skillers-share.git
cd skillers-share && bash install.sh

# 2) 표지 시안 눈으로 보기
python3 design-concepts/serve.py   # → 브라우저 localhost:8931
```
- `git` 없다고 나오면 맥은 `xcode-select --install` (몇 분)
- **편집·개발**하려면: 이 클론 폴더에서 고치고 `git add -A && git commit && git push`. 끝나면 `bash verify.sh` 로 검사

## 지금 상태 (이번 세션에 한 것)
- **표지 시안 볼드 고딕 6종** — `design-concepts/04-표지-볼드고딕-6종.html`
  A 화이트 제품 · B 다크 오케 · C 블랙&화이트+라임 · D SpaceX 풀블리드 · E Pilo 도형+볼드컬러 · F Young Yandex 가운데 대형
- **세리프(명조) 전면 제거** — 전부 볼드 고딕. `themes.md`에 규칙 박음
- **애니 = 오브젝트가 움직임**(배경 아님) 규칙
- **레이아웃 패턴에 "가운데 초대형(F)" 추가** — 좌측 정렬만 쓰지 말 것
- **새 슬라이드 종류**(webdeck에 추가·푸시): `producthero`(애플풍 제품) · `orchrun`(오케 자동재생 그래프) · `harnessflow`(하네스+게이트). 주제별 매핑은 `themes.md` "새 슬라이드 무기" 표
- getdesign.md 스타일표 반영 (Stripe·Nike·Discord·Shopify·Apple)

## 남은 TODO
- [ ] **원클릭 배포** `deploy.sh` — 지금은 GitHub Pages 올릴 때 명령 여러 개(수동). 하나로 묶기 (아직 안 함)
- [ ] 표지 시안 애니 미세조정 — D 로켓·F 원이 상단 라벨과 살짝 겹침
- [ ] 테마 토큰 일부는 레퍼런스에서 색·폰트 더 뽑을 여지 (docs/설계.md §14)

## 규칙 (어기면 반려)
- **세리프·명조 금지** — 전부 볼드 고딕(Pretendard/Paperlogy 900)
- 움직이는 표지는 **오브젝트 하나만** (배경 흐름 X)
- 발표 내용 지어내기 금지 — 숫자·사례는 발표자만 앎, 빈칸으로 두고 물음
- webdeck 원본(index.html·generate_deck.py) 수정 금지 — 확장은 별도 파일

---
문의 순서: 이 파일 → `SKILL.md` → `docs/설계.md`
