# 스킬러스 공유회

스폰지클럽 이기적 공유회(1시간) 발표를 **주제 선정부터 발표 스크립트까지** 만들어주는 클로드 스킬.

## 뭘 해주나

질문 3개에 답하면 이게 나온다.

- **제목** — 셸 결제로 들어오는 유료 공유회라, 모객되는 제목으로
- **목차** — 1시간 시간 배분 + 슬라이드 25~35장
- **웹덱** — 어디서든 열리는 HTML 한 폴더 (발표자 노트 `S`, 구간 타이머 `T` 내장)
- **발표 스크립트** — 오프닝 축어 · 데모 체크리스트 · Q&A 예상 질문

주제가 막막해도 된다. **대화 기록을 훑어 후보를 먼저 깔아준다.**

**이 덱은 PPT처럼 보이면 실패다.** 제목+불릿 레이아웃, 가운데 놓인 작은 이미지, 그라데이션, 클립아트, 시스템 기본 폰트를 쓰지 않는다. 표지는 내지와 다른 규칙으로 만든다 — 한 장으로 발표를 파는 포스터다.

## 설치

```bash
git clone https://github.com/Koo-bon/skillers-share.git
cd skillers-share && bash install.sh
```

`install.sh` 가 webdeck 엔진을 자동으로 내려받는다.

## 함께 쓰는 스킬

`훅카피` · `크리틱디렉터` · `spec-guard` 가 **동봉되어 있다.** `install.sh` 가 같이 설치하므로 따로 받을 필요가 없다.

이미 설치돼 있으면 `이름.backup-날짜` 로 백업한 뒤 교체한다.

원본: [webdeck](https://github.com/Koo-bon/webdeck) · [spec-guard](https://github.com/Koo-bon/spec-guard)

## 쓰는 법

```
공유회 준비해줘
```

## 발표 중 단축키

| 키 | 기능 |
|---|---|
| `S` | 발표자 노트 열기·닫기 |
| `T` | 구간 타이머 켜기·끄기 |
| `Shift + R` | 타이머 리셋 |

타이머 구간 경계는 데모 유무에 따라 다릅니다 — 있으면 5·20·35·50분, 없으면 5·20·30·45분.

## 구조

```
SKILL.md              오케스트레이터 — 8단계 흐름
references/
  interview.md        질문 3개와 스캔 규칙
  types.md            공유회 유형 6종
  titles.md           제목 패턴과 훅카피 브리프
  timeline.md         1시간 배분
  script.md           발표 스크립트 지침
  themes.md           디자인 테마 5종 + 폰트·타이포 + PPT 티 금지 + 표지 규칙
engine/
  share-extend.css    발표자 노트 · 타이머 · 테마 폰트/타이포
  share-extend.js
  (webdeck 덱 엔진은 install.sh 가 내려받는다)
bundled/              동봉 스킬 — 훅카피 · 크리틱디렉터 · spec-guard
install.sh            설치
verify.sh             번들 구조 검증
```

## 개발

```bash
bash verify.sh
```
