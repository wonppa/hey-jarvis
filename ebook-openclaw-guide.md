# 나만의 AI 비서 만들기: OpenClaw 완전 정복 가이드

> 비개발자도 따라할 수 있는, 월 $5로 개인 AI 비서를 만드는 실전 가이드
>
> 이 책은 실제 셋업 과정에서 겪은 시행착오와 해결 과정을 그대로 담았습니다.
> 에러 하나하나, 명령어 하나하나를 빠짐없이 설명합니다.

---

## 목차

- [나만의 AI 비서 만들기: OpenClaw 완전 정복 가이드](#나만의-ai-비서-만들기-openclaw-완전-정복-가이드)
  - [목차](#목차)
- [Chapter 1. 이 책에서 만들 것](#chapter-1-이-책에서-만들-것)
  - [무엇을 만드나요?](#무엇을-만드나요)
  - [전체 구조 한눈에 보기](#전체-구조-한눈에-보기)
  - [이 책에서 사용하는 AI 모델: GLM-5](#이-책에서-사용하는-ai-모델-glm-5)
- [Chapter 2. 내 컴퓨터 준비하기](#chapter-2-내-컴퓨터-준비하기)
  - [2-1. Homebrew 설치](#2-1-homebrew-설치)
    - [이미 설치되어 있는지 확인](#이미-설치되어-있는지-확인)
    - [Homebrew 설치하기](#homebrew-설치하기)
    - [설치 후 PATH 설정 (Apple Silicon Mac만 해당)](#설치-후-path-설정-apple-silicon-mac만-해당)
    - [설치 확인](#설치-확인)
  - [2-2. Node.js 설치](#2-2-nodejs-설치)
    - [이미 설치되어 있는지 확인](#이미-설치되어-있는지-확인-1)
    - [Node.js 설치하기](#nodejs-설치하기)
    - [설치 확인](#설치-확인-1)
  - [2-3. pnpm 설치](#2-3-pnpm-설치)
    - [설치 확인](#설치-확인-2)
  - [2-4. Git 설치 확인](#2-4-git-설치-확인)
  - [2-5. 텍스트 에디터 준비](#2-5-텍스트-에디터-준비)
    - [VS Code 설치](#vs-code-설치)
    - [VS Code로 폴더 열기](#vs-code로-폴더-열기)
    - [설치 완료 체크리스트](#설치-완료-체크리스트)
- [Chapter 3. AI 모델 준비하기 - Fireworks AI 가입](#chapter-3-ai-모델-준비하기---fireworks-ai-가입)
  - [3-1. 왜 Fireworks AI인가?](#3-1-왜-fireworks-ai인가)
  - [3-2. Fireworks AI 가입하기](#3-2-fireworks-ai-가입하기)
  - [3-3. API 키 발급받기](#3-3-api-키-발급받기)
- [Chapter 4. OpenClaw 설치하기](#chapter-4-openclaw-설치하기)
  - [4-1. OpenClaw란?](#4-1-openclaw란)
  - [4-2. OpenClaw CLI 설치](#4-2-openclaw-cli-설치)
    - [설치 확인](#설치-확인-3)
- [Chapter 5. 프로젝트 만들기](#chapter-5-프로젝트-만들기)
  - [5-1. 프로젝트 폴더 만들기](#5-1-프로젝트-폴더-만들기)
  - [5-2. package.json 만들기](#5-2-packagejson-만들기)
  - [5-3. 의존성 설치하기](#5-3-의존성-설치하기)
  - [5-4. 환경변수 파일 만들기](#5-4-환경변수-파일-만들기)
    - [.env.example 만들기 (템플릿)](#envexample-만들기-템플릿)
    - [.env 만들기 (실제 설정)](#env-만들기-실제-설정)
  - [5-5. OpenClaw 기본 설정 파일 만들기](#5-5-openclaw-기본-설정-파일-만들기)
  - [5-6. 서버 코드 작성하기](#5-6-서버-코드-작성하기)
  - [5-7. .gitignore 만들기](#5-7-gitignore-만들기)
    - [프로젝트 구조 확인](#프로젝트-구조-확인)
- [Chapter 6. OpenClaw 온보딩 - AI 연결하기](#chapter-6-openclaw-온보딩---ai-연결하기)
  - [6-1. 온보딩이란?](#6-1-온보딩이란)
  - [6-2. Fireworks AI + GLM-5로 온보딩](#6-2-fireworks-ai--glm-5로-온보딩)
  - [6-3. 컨텍스트 윈도우 수정 (매우 중요!)](#6-3-컨텍스트-윈도우-수정-매우-중요)
  - [6-4. 게이트웨이 재시작](#6-4-게이트웨이-재시작)
  - [6-5. 상태 확인하기](#6-5-상태-확인하기)
- [Chapter 7. 첫 대화 시작하기](#chapter-7-첫-대화-시작하기)
  - [7-1. 대시보드 열기](#7-1-대시보드-열기)
  - [7-2. 채팅해보기](#7-2-채팅해보기)
- [Chapter 8. 서버로 실행하기 (로컬 테스트)](#chapter-8-서버로-실행하기-로컬-테스트)
  - [8-1. 서버 실행](#8-1-서버-실행)
  - [8-2. 헬스체크 확인](#8-2-헬스체크-확인)
- [Chapter 9. Railway에 배포하기 (24시간 운영)](#chapter-9-railway에-배포하기-24시간-운영)
  - [9-1. Railway란?](#9-1-railway란)
  - [9-2. 배포 준비 파일](#9-2-배포-준비-파일)
    - [Dockerfile](#dockerfile)
    - [entrypoint.sh (시작 스크립트)](#entrypointsh-시작-스크립트)
    - [railway.toml (Railway 설정)](#railwaytoml-railway-설정)
  - [9-3. GitHub에 코드 올리기](#9-3-github에-코드-올리기)
    - [GitHub 레포 만들기](#github-레포-만들기)
    - [코드 올리기](#코드-올리기)
  - [9-4. Railway 배포 과정](#9-4-railway-배포-과정)
  - [9-5. 환경변수 설정](#9-5-환경변수-설정)
  - [9-6. 배포 확인](#9-6-배포-확인)
- [Chapter 10. 트러블슈팅 - 에러가 나면 이렇게](#chapter-10-트러블슈팅---에러가-나면-이렇게)
  - [에러 1: `device token mismatch`](#에러-1-device-token-mismatch)
  - [에러 2: `gateway token missing`](#에러-2-gateway-token-missing)
  - [에러 3: `Model context window too small`](#에러-3-model-context-window-too-small)
  - [에러 4: `gateway.bind: Invalid input`](#에러-4-gatewaybind-invalid-input)
  - [에러 5: `Unrecognized keys` (설정 파일 에러)](#에러-5-unrecognized-keys-설정-파일-에러)
  - [에러 6: 채팅을 보냈는데 응답이 안 올 때](#에러-6-채팅을-보냈는데-응답이-안-올-때)
  - [만능 해결법: 자동 진단](#만능-해결법-자동-진단)
- [Chapter 11. 다른 AI 모델로 바꾸기](#chapter-11-다른-ai-모델로-바꾸기)
  - [ChatGPT Pro 구독으로 바꾸기](#chatgpt-pro-구독으로-바꾸기)
  - [다시 GLM-5로 돌아가기](#다시-glm-5로-돌아가기)
  - [사용 가능한 인증 방식 목록](#사용-가능한-인증-방식-목록)
- [Chapter 12. 비용 가이드](#chapter-12-비용-가이드)
  - [모델별 가격 비교 (100만 토큰당)](#모델별-가격-비교-100만-토큰당)
  - [월간 예상 비용](#월간-예상-비용)
    - [Railway 호스팅 비용 (24시간 운영 시)](#railway-호스팅-비용-24시간-운영-시)
    - [총 비용 예시](#총-비용-예시)
- [Chapter 13. 데이터 프라이버시 - 내 데이터는 안전한가?](#chapter-13-데이터-프라이버시---내-데이터는-안전한가)
  - [중국 모델 직접 API = 위험](#중국-모델-직접-api--위험)
  - [이 가이드의 방법 = 안전](#이-가이드의-방법--안전)
  - [왜 Fireworks AI는 안전한가?](#왜-fireworks-ai는-안전한가)
  - [핵심 원칙 3가지](#핵심-원칙-3가지)
- [Chapter 14. 명령어 치트시트](#chapter-14-명령어-치트시트)
  - [설치 \& 설정](#설치--설정)
  - [게이트웨이 관리](#게이트웨이-관리)
  - [설정 변경](#설정-변경)
  - [초기화 \& 재설정](#초기화--재설정)
  - [서버 실행](#서버-실행)
- [부록 A. 전체 프로젝트 파일 모음](#부록-a-전체-프로젝트-파일-모음)
  - [폴더 구조](#폴더-구조)
  - [.env.example](#envexample)
  - [.gitignore](#gitignore)
  - [Dockerfile](#dockerfile-1)
  - [entrypoint.sh](#entrypointsh)
  - [openclaw.json](#openclawjson)
  - [package.json](#packagejson)
  - [railway.toml](#railwaytoml)
  - [src/server.js](#srcserverjs)
- [부록 B. 용어 사전](#부록-b-용어-사전)

---

# Chapter 1. 이 책에서 만들 것

## 무엇을 만드나요?

이 책을 따라하면, 여러분만의 **개인 AI 비서**를 갖게 됩니다.

ChatGPT처럼 대화할 수 있는 AI인데, 차이점이 있습니다:

| | ChatGPT | 우리가 만들 것 |
|---|---------|--------------|
| **비용** | 월 $20~$200 | 월 $3~$30 |
| **모델 선택** | GPT만 가능 | GLM, DeepSeek, Gemini 등 자유롭게 |
| **데이터** | OpenAI 서버에 저장 | 내 서버에서만 처리 |
| **확장성** | 제한적 | Telegram, Slack 등 연결 가능 |
| **24시간 운영** | 웹에서만 | 내 서버에서 항상 동작 |

## 전체 구조 한눈에 보기

```
여러분(브라우저/Telegram)
        │
        ▼
  ┌─────────────────┐
  │  Express 서버    │  ← 여러분이 만들 서버 (포트 8080)
  │  (hey-jarvis)   │
  └────────┬────────┘
           │
           ▼
  ┌─────────────────┐
  │  OpenClaw       │  ← AI 게이트웨이 (포트 18789)
  │  Gateway        │
  └────────┬────────┘
           │
           ▼
  ┌─────────────────┐
  │  Fireworks AI   │  ← AI 모델 API (미국 서버)
  │  (GLM-5)        │
  └─────────────────┘
```

쉽게 말하면:

1. **Express 서버** = 접수처. 여러분의 요청을 받아서 아래로 전달합니다.
2. **OpenClaw Gateway** = 매니저. AI 모델과의 대화를 관리합니다.
3. **Fireworks AI** = 실제 AI. 여러분의 질문에 답변을 생성합니다.

## 이 책에서 사용하는 AI 모델: GLM-5

**GLM-5**는 중국 Zhipu AI가 만든 대규모 AI 모델입니다.

- **파라미터**: 744B (7,440억개) - GPT-4급
- **컨텍스트**: 200,000 토큰 - 책 한 권 분량의 대화 가능
- **라이선스**: MIT (무료 사용 가능)
- **비용**: 입력 $0.80 / 출력 $2.56 (100만 토큰당) - ChatGPT의 1/10 수준

> **잠깐, 중국 AI라고요? 데이터가 중국으로 가나요?**
>
> 아닙니다! 우리는 **Fireworks AI**라는 미국 회사를 통해 GLM-5를 사용합니다.
> Fireworks AI는 미국 서버에서 GLM-5를 실행하므로, 여러분의 데이터는 중국으로 전송되지 않습니다.
> 자세한 내용은 [Chapter 13](#chapter-13-데이터-프라이버시---내-데이터는-안전한가)에서 다룹니다.

---

# Chapter 2. 내 컴퓨터 준비하기

이 챕터에서는 AI 비서를 만들기 위한 도구들을 설치합니다.

> **이 가이드는 macOS 기준입니다.** Windows 사용자는 WSL2(Windows Subsystem for Linux)를 먼저 설치하세요.

## 2-1. Homebrew 설치

**Homebrew**는 맥에서 프로그램을 쉽게 설치할 수 있게 해주는 도구입니다.
앱스토어 같은 건데, 개발 도구 전용이라고 생각하면 됩니다.

### 이미 설치되어 있는지 확인

터미널을 열어주세요.

> **터미널 여는 법**: `Cmd + Space`를 누르고 "터미널" 또는 "Terminal"을 검색해서 실행

```bash
brew --version
```

**이렇게 나오면 이미 설치된 것입니다** (버전 번호는 다를 수 있음):
```
Homebrew 4.4.16
```

**`command not found`라고 나오면** 아래 단계를 따라 설치하세요.

### Homebrew 설치하기

터미널에 아래 명령어를 **한 줄 통째로** 복사해서 붙여넣기 하세요:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**무슨 일이 일어나나요?**

1. 컴퓨터 비밀번호를 물어봅니다 → 입력하세요 (입력할 때 화면에 아무것도 안 보이는 게 정상)
2. "Press RETURN to continue" → Enter 키를 누르세요
3. 설치가 진행됩니다 (2~5분 소요)

### 설치 후 PATH 설정 (Apple Silicon Mac만 해당)

M1, M2, M3, M4 칩 맥북을 사용한다면 추가 설정이 필요합니다:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

> **팁**: 본인 맥이 Apple Silicon인지 모르겠다면, 왼쪽 상단 Apple 로고 > "이 Mac에 관하여"에서 "칩"이 M으로 시작하면 Apple Silicon입니다.

### 설치 확인

```bash
brew --version
```

버전 번호가 나오면 성공입니다!

---

## 2-2. Node.js 설치

**Node.js**는 JavaScript를 실행할 수 있게 해주는 프로그램입니다.
우리가 만들 서버가 Node.js로 동작합니다.

### 이미 설치되어 있는지 확인

```bash
node --version
```

`v22` 이상이 나오면 이미 준비된 것입니다. 다음 단계로 넘어가세요.

### Node.js 설치하기

```bash
brew install node
```

**무슨 일이 일어나나요?**

1. Homebrew가 Node.js를 다운로드합니다
2. 자동으로 설치됩니다 (1~3분 소요)
3. `npm`(패키지 관리자)도 같이 설치됩니다

### 설치 확인

```bash
node --version
```

**기대 결과** (버전 번호는 달라도 됩니다):
```
v22.14.0
```

```bash
npm --version
```

**기대 결과**:
```
10.9.2
```

> **버전이 22보다 낮다면?**
>
> ```bash
> brew upgrade node
> ```
> 이 명령어로 최신 버전으로 업그레이드하세요.

---

## 2-3. pnpm 설치

**pnpm**은 npm보다 빠르고 효율적인 패키지 관리자입니다.
npm으로도 할 수 있지만, pnpm이 더 빠르고 디스크 공간도 적게 씁니다.

```bash
npm install -g pnpm
```

> **`-g`가 뭔가요?** "global"의 약자로, 이 컴퓨터 어디서든 사용할 수 있게 설치한다는 의미입니다.

### 설치 확인

```bash
pnpm --version
```

**기대 결과** (버전은 다를 수 있음):
```
9.15.5
```

---

## 2-4. Git 설치 확인

**Git**은 코드를 관리하는 도구입니다. macOS에는 보통 기본 설치되어 있습니다.

```bash
git --version
```

**기대 결과**:
```
git version 2.47.1
```

만약 설치되어 있지 않다면:

```bash
brew install git
```

---

## 2-5. 텍스트 에디터 준비

코드를 편집할 때 사용할 에디터가 필요합니다. 아무거나 괜찮지만, **VS Code**를 추천합니다.

### VS Code 설치

```bash
brew install --cask visual-studio-code
```

또는 https://code.visualstudio.com 에서 다운로드

### VS Code로 폴더 열기

나중에 프로젝트를 만든 후 이 명령어로 열 수 있습니다:

```bash
code hey-jarvis
```

---

### 설치 완료 체크리스트

모든 것이 제대로 설치되었는지 한번에 확인해봅시다:

```bash
echo "=== 설치 확인 ==="
echo "Homebrew: $(brew --version 2>/dev/null | head -1 || echo '미설치')"
echo "Node.js:  $(node --version 2>/dev/null || echo '미설치')"
echo "npm:      $(npm --version 2>/dev/null || echo '미설치')"
echo "pnpm:     $(pnpm --version 2>/dev/null || echo '미설치')"
echo "Git:      $(git --version 2>/dev/null || echo '미설치')"
echo "================="
```

**기대 결과** (버전은 다를 수 있음):

```
=== 설치 확인 ===
Homebrew: Homebrew 4.4.16
Node.js:  v22.14.0
npm:      10.9.2
pnpm:     9.15.5
Git:      git version 2.47.1
=================
```

모두 나왔나요? 그러면 다음으로 넘어갑시다!

---

# Chapter 3. AI 모델 준비하기 - Fireworks AI 가입

## 3-1. 왜 Fireworks AI인가?

GLM-5를 사용하는 방법은 여러 가지가 있습니다:

| 방법 | 장점 | 단점 |
|------|------|------|
| **Zhipu AI 직접** | 가장 저렴 | 데이터가 중국으로 감 |
| **Fireworks AI** | 미국 서버, 빠름 | 약간 비쌈 |
| **Together AI** | 미국 서버 | Fireworks보다 느림 |
| **OpenRouter** | 다양한 모델 | 중개 수수료 있음 |

**우리는 Fireworks AI를 선택합니다.** 이유:

1. **데이터 안전**: 미국 서버에서만 처리 (중국 전송 없음)
2. **빠른 속도**: 추론 속도 최적화에 특화된 회사
3. **합리적 가격**: 100만 토큰당 입력 $0.80 / 출력 $2.56
4. **안정성**: 대형 기업들이 사용하는 인프라

## 3-2. Fireworks AI 가입하기

1. https://fireworks.ai 접속
2. 우측 상단 **"Sign Up"** 클릭
3. Google 계정 또는 이메일로 가입
4. 이메일 인증 완료

## 3-3. API 키 발급받기

가입 후:

1. 로그인 상태에서 https://fireworks.ai/account/api-keys 접속
2. **"Create API Key"** 버튼 클릭
3. 키 이름 입력 (예: `hey-jarvis`)
4. **"Create"** 클릭
5. 생성된 키를 **반드시 복사해서 어딘가에 저장**하세요!

> **매우 중요**: API 키는 생성 직후에만 볼 수 있습니다. 페이지를 벗어나면 다시 볼 수 없으니 반드시 복사해두세요.

키는 이런 형태입니다:

```
fw_3Abc7DeFgHiJkLmNoPqR1234
```

`fw_`로 시작하는 긴 문자열입니다. 이걸 안전한 곳에 저장해두세요.

---

# Chapter 4. OpenClaw 설치하기

## 4-1. OpenClaw란?

**OpenClaw**은 오픈소스 개인 AI 비서 게이트웨이입니다.

쉽게 말하면:
- AI 모델(GLM-5, GPT 등)과 여러분 사이를 연결해주는 **다리** 같은 역할
- 웹 대시보드, Telegram, Slack 등 다양한 **입구**를 제공
- 대화 기록 관리, 모델 전환 등을 자동으로 처리

## 4-2. OpenClaw CLI 설치

**CLI**(Command Line Interface)는 터미널에서 사용하는 명령어 도구입니다.

```bash
npm install -g openclaw@latest
```

### 설치 확인

```bash
openclaw --version
```

**기대 결과**:
```
2026.2.14
```

> **에러가 나나요?**
>
> `EACCES: permission denied` 에러가 나면:
> ```bash
> sudo npm install -g openclaw@latest
> ```
> 컴퓨터 비밀번호를 입력하면 됩니다.

---

# Chapter 5. 프로젝트 만들기

이제 실제 프로젝트를 만들어봅시다. 하나하나 따라하면 됩니다.

## 5-1. 프로젝트 폴더 만들기

원하는 위치에 프로젝트 폴더를 만듭니다:

```bash
mkdir hey-jarvis
cd hey-jarvis
mkdir src
```

**명령어 설명**:
- `mkdir hey-jarvis` = "hey-jarvis"라는 폴더를 만들어라
- `cd hey-jarvis` = 그 폴더 안으로 들어가라
- `mkdir src` = 소스코드를 넣을 "src" 폴더를 만들어라

## 5-2. package.json 만들기

`package.json`은 이 프로젝트가 어떤 프로젝트인지, 어떤 도구들이 필요한지 적어놓는 **설명서** 같은 파일입니다.

터미널에서 아래 명령어를 실행하세요:

```bash
cat > package.json << 'EOF'
{
  "name": "hey-jarvis",
  "version": "1.0.0",
  "private": true,
  "description": "OpenClaw gateway with Fireworks AI + GLM-5",
  "scripts": {
    "start": "node src/server.js",
    "dev": "node src/server.js"
  },
  "dependencies": {
    "dotenv": "^17.3.1",
    "express": "^5.1.0",
    "http-proxy": "^1.18.1",
    "ws": "^8.18.0"
  },
  "engines": {
    "node": ">=22"
  }
}
EOF
```

**각 항목 설명**:

| 항목 | 의미 |
|------|------|
| `name` | 프로젝트 이름 |
| `scripts.start` | `pnpm start`로 실행할 명령어 |
| `dependencies` | 이 프로젝트가 사용하는 외부 도구들 |
| `dotenv` | .env 파일에서 설정값을 읽는 도구 |
| `express` | 웹 서버를 만드는 도구 |
| `http-proxy` | 요청을 다른 서버로 전달하는 도구 |
| `ws` | 실시간 통신(WebSocket) 도구 |

## 5-3. 의존성 설치하기

```bash
pnpm install
```

**무슨 일이 일어나나요?**

`package.json`에 적힌 도구들(express, dotenv 등)을 인터넷에서 다운로드해서 `node_modules` 폴더에 설치합니다.

**기대 결과** (비슷하면 됩니다):
```
Packages: +85
++++++++++++++++++++++++++++
Progress: resolved 85, reused 0, downloaded 85, added 85, done
```

설치 후 폴더 구조:
```
hey-jarvis/
├── node_modules/      ← 방금 설치된 도구들 (건드리지 마세요)
├── package.json
├── pnpm-lock.yaml     ← 자동 생성된 파일 (건드리지 마세요)
└── src/
```

## 5-4. 환경변수 파일 만들기

**환경변수**란 비밀번호, API 키 같은 **민감한 설정값**을 코드와 분리해서 저장하는 방법입니다.

### .env.example 만들기 (템플릿)

이 파일은 "어떤 환경변수가 필요한지" 알려주는 **안내서** 역할입니다.
실제 값은 없고, 어떤 항목을 채워야 하는지만 적혀 있습니다.

```bash
cat > .env.example << 'EOF'
# === 필수 ===
FIREWORKS_API_KEY=your-fireworks-api-key-here
SETUP_PASSWORD=changeme
PORT=8080
EOF
```

### .env 만들기 (실제 설정)

`.env.example`을 복사해서 실제 값을 넣을 파일을 만듭니다:

```bash
cp .env.example .env
```

이제 `.env` 파일을 에디터로 열어서 **Fireworks AI API 키**를 넣으세요:

```bash
# VS Code가 있다면:
code .env

# 또는 nano 에디터:
nano .env
```

`.env` 파일 내용을 이렇게 수정하세요:

```env
# === 필수 ===
FIREWORKS_API_KEY=fw_3Abc7DeFgHiJkLmNoPqR1234
SETUP_PASSWORD=mypassword123
PORT=8080
```

> **주의**: `fw_3Abc7DeFgHiJkLmNoPqR1234` 부분을 [Chapter 3](#3-3-api-키-발급받기)에서 발급받은 **실제 API 키**로 바꾸세요!

> **nano 에디터 사용법**: 수정 후 `Ctrl + O` → `Enter`(저장) → `Ctrl + X`(나가기)

## 5-5. OpenClaw 기본 설정 파일 만들기

이 파일은 OpenClaw에게 "어떤 AI 모델을 사용하고, 어떻게 동작해야 하는지" 알려주는 설정 파일입니다.

```bash
cat > openclaw.json << 'EOF'
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "custom-api-fireworks-ai/accounts/fireworks/models/glm-5"
      }
    }
  },
  "gateway": {
    "mode": "local",
    "port": 18789,
    "bind": "loopback"
  }
}
EOF
```

**각 항목 설명**:

| 항목 | 의미 |
|------|------|
| `agents.defaults.model.primary` | 기본으로 사용할 AI 모델 |
| `gateway.mode: "local"` | 로컬에서만 실행 |
| `gateway.port: 18789` | 게이트웨이가 사용할 포트 번호 |
| `gateway.bind: "loopback"` | 이 컴퓨터에서만 접속 가능 (보안) |

## 5-6. 서버 코드 작성하기

이제 핵심인 서버 코드를 만듭니다. 이 파일이 모든 것을 연결해줍니다.

```bash
cat > src/server.js << 'SERVEREOF'
require("dotenv").config();

const express = require("express");
const http = require("http");
const httpProxy = require("http-proxy");
const { spawn } = require("child_process");
const fs = require("fs");
const path = require("path");

const PORT = parseInt(process.env.PORT || "8080", 10);
const GATEWAY_PORT = 18789;
const SETUP_PASSWORD = process.env.SETUP_PASSWORD || "";
const STATE_DIR =
  process.env.OPENCLAW_STATE_DIR ||
  path.join(process.env.HOME || "/home/openclaw", ".openclaw");
const CONFIG_PATH = path.join(STATE_DIR, "openclaw.json");

let gatewayProcess = null;
let gatewayReady = false;

// --- Config ---

function buildConfig() {
  const apiKey = process.env.FIREWORKS_API_KEY;
  if (!apiKey) return null;

  return {
    agents: {
      defaults: {
        model: {
          primary:
            "custom-api-fireworks-ai/accounts/fireworks/models/glm-5",
        },
      },
    },
    models: {
      providers: {
        "custom-api-fireworks-ai": {
          baseUrl: "https://api.fireworks.ai/inference/v1",
          apiKey: apiKey,
          models: [
            {
              id: "accounts/fireworks/models/glm-5",
              name: "GLM-5 (Fireworks)",
              contextWindow: 200000,
              maxTokens: 8192,
            },
          ],
        },
      },
    },
    gateway: {
      mode: "local",
      port: GATEWAY_PORT,
      bind: "loopback",
    },
  };
}

function ensureConfig() {
  fs.mkdirSync(STATE_DIR, { recursive: true });

  // .env에서 API 키를 읽어서 설정 파일 자동 생성
  const config = buildConfig();
  if (config) {
    fs.writeFileSync(CONFIG_PATH, JSON.stringify(config, null, 2));
    console.log("[hey-jarvis] Generated config from FIREWORKS_API_KEY.");
    return;
  }

  // .env에 키가 없으면 기본 템플릿 복사
  if (!fs.existsSync(CONFIG_PATH)) {
    const tpl = path.join(__dirname, "..", "openclaw.json");
    if (fs.existsSync(tpl)) {
      fs.copyFileSync(tpl, CONFIG_PATH);
      console.log("[hey-jarvis] Copied default config template.");
    }
  }
}

// --- Gateway Process Management ---

function startGateway() {
  console.log("[hey-jarvis] Starting OpenClaw gateway...");

  gatewayProcess = spawn(
    "openclaw",
    [
      "gateway",
      "run",
      "--port",
      String(GATEWAY_PORT),
      "--bind",
      "loopback",
      "--allow-unconfigured",
    ],
    {
      env: {
        ...process.env,
        OPENCLAW_STATE_DIR: STATE_DIR,
        OPENCLAW_CONFIG_PATH: CONFIG_PATH,
        OPENCLAW_WORKSPACE_DIR:
          process.env.OPENCLAW_WORKSPACE_DIR || "/data/workspace",
      },
      stdio: ["pipe", "pipe", "pipe"],
    }
  );

  gatewayProcess.stdout.on("data", (data) => {
    const msg = data.toString().trim();
    console.log(`[gateway] ${msg}`);
    if (
      msg.includes("listening") ||
      msg.includes("ready") ||
      msg.includes("Gateway")
    ) {
      gatewayReady = true;
      console.log("[hey-jarvis] Gateway is ready.");
    }
  });

  gatewayProcess.stderr.on("data", (data) => {
    const msg = data.toString().trim();
    if (msg) console.error(`[gateway:err] ${msg}`);
    if (msg.includes("listening") || msg.includes("ready")) {
      gatewayReady = true;
    }
  });

  gatewayProcess.on("exit", (code) => {
    console.log(`[hey-jarvis] Gateway exited with code ${code}`);
    gatewayReady = false;
    setTimeout(() => {
      console.log("[hey-jarvis] Restarting gateway...");
      startGateway();
    }, 3000);
  });

  setTimeout(() => {
    if (!gatewayReady) {
      gatewayReady = true;
      console.log("[hey-jarvis] Gateway assumed ready (timeout).");
    }
  }, 15000);
}

// --- Express App ---

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/healthz", (_req, res) => {
  res.json({
    status: "ok",
    gateway: gatewayReady ? "running" : "starting",
    timestamp: new Date().toISOString(),
  });
});

app.get("/setup/healthz", (_req, res) => res.json({ status: "ok" }));

// --- WebSocket Proxy to Gateway ---

const proxy = httpProxy.createProxyServer({
  target: `http://127.0.0.1:${GATEWAY_PORT}`,
  ws: true,
});

proxy.on("error", (err, _req, res) => {
  console.error("[proxy]", err.message);
  if (res && res.writeHead) {
    res.writeHead(502, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ error: "Gateway not ready" }));
  }
});

app.use((req, res) => {
  if (!gatewayReady) {
    return res.status(503).json({ error: "Gateway starting" });
  }
  proxy.web(req, res);
});

// --- Start ---

const server = http.createServer(app);

server.on("upgrade", (req, socket, head) => {
  if (gatewayReady) {
    proxy.ws(req, socket, head);
  } else {
    socket.destroy();
  }
});

ensureConfig();

server.listen(PORT, "0.0.0.0", () => {
  console.log(`[hey-jarvis] Listening on :${PORT}`);
  startGateway();
});

process.on("SIGTERM", () => {
  console.log("[hey-jarvis] Shutting down...");
  if (gatewayProcess) gatewayProcess.kill("SIGTERM");
  server.close(() => process.exit(0));
});
SERVEREOF
```

> **코드가 길어서 겁먹지 마세요!** 이 코드는 한 번만 만들면 됩니다. 핵심 동작은 간단합니다:
>
> 1. `.env` 파일에서 API 키를 읽는다
> 2. OpenClaw 설정 파일을 자동으로 생성한다
> 3. 웹 서버를 시작한다
> 4. OpenClaw 게이트웨이를 시작한다
> 5. 들어오는 요청을 게이트웨이로 전달한다

## 5-7. .gitignore 만들기

Git에 올리면 안 되는 파일들을 지정합니다. 특히 **API 키가 담긴 `.env` 파일**은 절대 올리면 안 됩니다!

```bash
cat > .gitignore << 'EOF'
node_modules/
.cache/
.env
/data/
*.log
EOF
```

---

### 프로젝트 구조 확인

모든 파일을 만들었으면, 폴더 구조가 이렇게 되어야 합니다:

```
hey-jarvis/
├── .env                ← API 키 (Git에 올리면 안 됨!)
├── .env.example        ← 환경변수 안내서
├── .gitignore          ← Git 제외 목록
├── node_modules/       ← 설치된 도구들
├── openclaw.json       ← OpenClaw 기본 설정
├── package.json        ← 프로젝트 설명서
├── pnpm-lock.yaml      ← 자동 생성
└── src/
    └── server.js       ← 핵심 서버 코드
```

---

# Chapter 6. OpenClaw 온보딩 - AI 연결하기

## 6-1. 온보딩이란?

**온보딩(Onboarding)**은 OpenClaw를 처음 사용할 때 필요한 초기 설정 과정입니다.

다음을 자동으로 해줍니다:
- AI 모델 프로바이더 연결
- 게이트웨이 인증 토큰 생성
- 시스템 데몬(자동 실행 서비스) 설치
- 필요한 폴더 생성

## 6-2. Fireworks AI + GLM-5로 온보딩

> **중요**: 아래 명령어에서 `YOUR_FIREWORKS_API_KEY` 부분을 [Chapter 3](#3-3-api-키-발급받기)에서 발급받은 실제 API 키로 바꾸세요!

```bash
openclaw onboard \
  --non-interactive \
  --accept-risk \
  --auth-choice custom-api-key \
  --custom-base-url "https://api.fireworks.ai/inference/v1" \
  --custom-api-key "YOUR_FIREWORKS_API_KEY" \
  --custom-model-id "accounts/fireworks/models/glm-5" \
  --custom-compatibility openai \
  --gateway-bind loopback \
  --skip-channels \
  --skip-skills \
  --skip-ui \
  --install-daemon
```

**각 옵션 설명**:

| 옵션 | 의미 |
|------|------|
| `--non-interactive` | 질문 없이 자동 진행 |
| `--accept-risk` | 보안 관련 동의 |
| `--auth-choice custom-api-key` | 커스텀 API 키 방식 사용 |
| `--custom-base-url` | Fireworks AI 서버 주소 |
| `--custom-api-key` | 여러분의 API 키 |
| `--custom-model-id` | 사용할 모델 (GLM-5) |
| `--custom-compatibility openai` | OpenAI 호환 모드 |
| `--gateway-bind loopback` | 로컬에서만 접속 가능 |
| `--skip-channels` | 채널 설정 건너뛰기 (나중에 가능) |
| `--skip-skills` | 스킬 설정 건너뛰기 |
| `--skip-ui` | UI 설정 건너뛰기 |
| `--install-daemon` | 자동 시작 서비스 설치 |

**성공하면 이런 메시지가 나옵니다:**

```
Updated ~/.openclaw/openclaw.json
Workspace OK: ~/.openclaw/workspace
Sessions OK: ~/.openclaw/agents/main/sessions
Installed LaunchAgent: ~/Library/LaunchAgents/ai.openclaw.gateway.plist
```

## 6-3. 컨텍스트 윈도우 수정 (매우 중요!)

> **이 단계를 건너뛰면 채팅이 작동하지 않습니다!**

온보딩은 기본적으로 컨텍스트 윈도우를 **4,096 토큰**으로 설정합니다.
하지만 OpenClaw는 **최소 16,000 토큰**이 필요하고, GLM-5는 **200,000 토큰**까지 지원합니다.

수정하지 않으면 이런 에러가 발생합니다:

```
❌ Model context window too small (4096 tokens). Minimum is 16000.
```

**수정 명령어:**

```bash
openclaw config set models.providers.custom-api-fireworks-ai.models.0.contextWindow 200000
```

```bash
openclaw config set models.providers.custom-api-fireworks-ai.models.0.maxTokens 8192
```

**명령어 설명**:
- `contextWindow 200000` = AI가 한 번에 기억할 수 있는 텍스트 양 (200,000 토큰 = 책 한 권 분량)
- `maxTokens 8192` = AI가 한 번에 생성할 수 있는 최대 답변 길이

각각 실행 후 이런 메시지가 나오면 성공입니다:

```
Updated models.providers.custom-api-fireworks-ai.models.0.contextWindow. Restart the gateway to apply.
```

## 6-4. 게이트웨이 재시작

설정을 변경했으니 게이트웨이를 재시작해야 합니다:

```bash
openclaw gateway restart
```

**기대 결과:**
```
Restarted LaunchAgent: gui/501/ai.openclaw.gateway
```

## 6-5. 상태 확인하기

모든 것이 제대로 되었는지 확인합시다:

```bash
openclaw status
```

**정상이면 이렇게 나옵니다** (중요한 부분만):

```
Gateway         local · ws://127.0.0.1:18789 · reachable 32ms · auth token
Gateway service LaunchAgent installed · loaded · running (pid 12345)
Sessions        default accounts/fireworks/models/glm-5 (200k ctx)
```

**확인할 포인트 3가지:**

1. ✅ `Gateway` 줄에 `reachable`이 있는가? → 게이트웨이 연결 성공
2. ✅ `Gateway service` 줄에 `running`이 있는가? → 서비스 실행 중
3. ✅ `Sessions` 줄에 `200k ctx`가 있는가? → 컨텍스트 윈도우 수정 성공

> **`reachable`이 아니라 에러가 나나요?** [Chapter 10. 트러블슈팅](#chapter-10-트러블슈팅---에러가-나면-이렇게)을 참고하세요.

---

# Chapter 7. 첫 대화 시작하기

드디어 AI와 대화할 시간입니다!

## 7-1. 대시보드 열기

```bash
openclaw dashboard
```

이 명령어를 실행하면:

1. 인증 토큰이 포함된 URL이 생성됩니다
2. 브라우저가 자동으로 열립니다
3. OpenClaw 대시보드가 나타납니다

URL은 이런 형태입니다:
```
http://127.0.0.1:18789/#token=a1b2c3d4e5f6...
```

> **브라우저가 자동으로 안 열리나요?**
>
> 위 URL을 복사해서 브라우저 주소창에 직접 붙여넣기 하세요.

> **"device token mismatch" 에러가 뜨나요?**
>
> 이전 세션이 남아있어서 그렇습니다.
> **시크릿 모드**(Cmd + Shift + N)로 브라우저를 열고 URL을 붙여넣기 하세요.

## 7-2. 채팅해보기

대시보드가 열리면 채팅 입력창이 보일 것입니다.

한 번 인사해보세요:

```
안녕! 너는 누구야?
```

GLM-5가 응답하면 성공입니다! 🎉

첫 응답이 오기까지 3~10초 정도 걸릴 수 있습니다. 이후부터는 더 빨라집니다.

---

# Chapter 8. 서버로 실행하기 (로컬 테스트)

지금까지는 OpenClaw를 직접 실행했습니다.
이제 우리가 만든 **Express 서버**를 통해 실행해봅시다.

## 8-1. 서버 실행

> **먼저 기존 게이트웨이를 중지하세요** (이중 실행 방지):
>
> ```bash
> openclaw gateway stop
> ```

```bash
cd hey-jarvis
pnpm start
```

**기대 결과:**

```
[hey-jarvis] Generated config from FIREWORKS_API_KEY.
[hey-jarvis] Listening on :8080
[hey-jarvis] Starting OpenClaw gateway...
[gateway] Gateway started on ws://127.0.0.1:18789
[hey-jarvis] Gateway is ready.
```

서버가 실행되면:
- `http://localhost:8080` = Express 서버 (외부용)
- `http://127.0.0.1:18789` = OpenClaw 게이트웨이 (내부용)

## 8-2. 헬스체크 확인

새 터미널 탭을 열고 (`Cmd + T`):

```bash
curl http://localhost:8080/healthz
```

**기대 결과:**

```json
{"status":"ok","gateway":"running","timestamp":"2026-02-16T01:30:00.000Z"}
```

`"gateway":"running"`이 보이면 서버와 게이트웨이 모두 정상입니다!

> **서버 중지하려면:** 서버가 실행 중인 터미널에서 `Ctrl + C`를 누르세요.

---

# Chapter 9. Railway에 배포하기 (24시간 운영)

지금까지는 여러분의 맥에서만 실행됩니다. 맥을 끄면 AI 비서도 꺼집니다.
**Railway**에 배포하면 24시간 365일 운영할 수 있습니다.

## 9-1. Railway란?

Railway는 서버를 쉽게 배포할 수 있는 클라우드 서비스입니다.
AWS, GCP보다 훨씬 쉽고, 취미 프로젝트에 적합한 가격입니다.

| 항목 | 비용 |
|------|------|
| Hobby 플랜 | $5/월 |
| 사용량 (CPU/RAM) | ~$5/월 |
| **합계** | **~$10/월** |

## 9-2. 배포 준비 파일

### Dockerfile

Docker는 여러분의 프로젝트를 **하나의 박스**로 포장해서 어디서든 실행할 수 있게 합니다.

```bash
cat > Dockerfile << 'EOF'
FROM node:22-bookworm-slim

# 시스템 도구 설치
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# pnpm 설치
RUN corepack enable && corepack prepare pnpm@latest --activate

# OpenClaw CLI 설치
RUN npm install -g openclaw@latest

# 앱 폴더 설정
WORKDIR /app

# 의존성 파일 복사 및 설치
COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile 2>/dev/null || pnpm install

# 소스코드 복사
COPY . .

# 시작 스크립트 실행 권한 부여
RUN chmod +x entrypoint.sh

# 보안용 일반 사용자 생성
RUN groupadd -r openclaw && useradd -r -g openclaw -m openclaw

# 데이터 폴더 생성
RUN mkdir -p /data/.openclaw /data/workspace && \
    chown -R openclaw:openclaw /data /app

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
EOF
```

### entrypoint.sh (시작 스크립트)

```bash
cat > entrypoint.sh << 'EOF'
#!/bin/bash
set -e

mkdir -p /data/.openclaw /data/workspace

if [ ! -f /data/.openclaw/openclaw.json ]; then
  echo "No config found. Copying default config..."
  cp /app/openclaw.json /data/.openclaw/openclaw.json
fi

chown -R openclaw:openclaw /data

export OPENCLAW_STATE_DIR=/data/.openclaw
export OPENCLAW_WORKSPACE_DIR=/data/workspace
export HOME=/home/openclaw

exec su -s /bin/bash openclaw -c "node /app/src/server.js"
EOF

chmod +x entrypoint.sh
```

### railway.toml (Railway 설정)

```bash
cat > railway.toml << 'EOF'
[build]
builder = "dockerfile"

[deploy]
healthcheckPath = "/healthz"
healthcheckTimeout = 300
restartPolicyType = "on_failure"
restartPolicyMaxRetries = 5
EOF
```

## 9-3. GitHub에 코드 올리기

Railway는 GitHub에서 코드를 가져오므로, 먼저 GitHub에 올려야 합니다.

### GitHub 레포 만들기

1. https://github.com/new 접속
2. Repository name: `hey-jarvis`
3. **Private** 선택 (API 키 보호)
4. **"Create repository"** 클릭

### 코드 올리기

```bash
cd hey-jarvis

git init
git add .
git commit -m "Initial commit: OpenClaw + Fireworks AI + GLM-5"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/hey-jarvis.git
git push -u origin main
```

> **YOUR_USERNAME**을 본인의 GitHub 아이디로 바꾸세요!

> **주의**: `.gitignore`에 `.env`가 포함되어 있으므로 API 키는 GitHub에 올라가지 않습니다. 안전합니다.

## 9-4. Railway 배포 과정

1. https://railway.com 에서 가입/로그인
2. **"New Project"** 클릭
3. **"Deploy from GitHub Repo"** 선택
4. `hey-jarvis` 레포 선택
5. **Volume 추가**: "Add Volume" → Mount path에 `/data` 입력

> **Volume이 뭔가요?** 서버가 재시작되어도 데이터(설정, 대화 기록)가 유지되는 저장 공간입니다.

## 9-5. 환경변수 설정

Railway 대시보드에서:

1. 프로젝트 클릭
2. **"Variables"** 탭 클릭
3. 다음 변수 추가:

```
PORT=8080
SETUP_PASSWORD=안전한비밀번호입력
FIREWORKS_API_KEY=fw_여러분의실제API키
```

> **Railway에서는 .env 파일 대신 Variables 설정을 사용합니다.**

## 9-6. 배포 확인

환경변수 설정 후 자동으로 배포가 시작됩니다.

1. **Build 로그** 확인: 약 2~5분 소요
2. 배포 완료 후 Railway가 제공하는 URL 확인 (예: `https://hey-jarvis-production.up.railway.app`)
3. 헬스체크:

```bash
curl https://hey-jarvis-production.up.railway.app/healthz
```

```json
{"status":"ok","gateway":"running","timestamp":"..."}
```

이 결과가 나오면 24시간 운영되는 AI 비서 배포 완료입니다! 🎉

---

# Chapter 10. 트러블슈팅 - 에러가 나면 이렇게

실제 셋업 과정에서 자주 만나는 에러들과 해결법입니다.
이 챕터의 모든 해결법은 실제로 겪고 해결한 것들입니다.

## 에러 1: `device token mismatch`

```
❌ disconnected (1008): unauthorized: device token mismatch
```

**무슨 뜻인가요?**

브라우저에 이전 세션의 인증 정보가 남아있어서, 새로운 게이트웨이와 맞지 않는 겁니다.

**해결 방법 (쉬운 것부터):**

**방법 1** - 시크릿 모드로 접속:
```
Cmd + Shift + N (Chrome/Edge)
```
시크릿 모드에서 `openclaw dashboard` URL을 붙여넣기

**방법 2** - 브라우저 데이터 삭제:
1. 브라우저에서 `F12` (개발자 도구 열기)
2. **Application** 탭 클릭
3. 왼쪽에서 **Local Storage** → `http://127.0.0.1:18789` 선택
4. 오른쪽 목록에서 **모두 삭제** (우클릭 → Clear)
5. 페이지 새로고침 (`Cmd + R`)

**방법 3** - 완전 초기화 (최후의 수단):

```bash
# 1. 게이트웨이 중지
openclaw gateway stop

# 2. 전체 삭제
openclaw uninstall --all --non-interactive --yes

# 3. 이전 버전 찌꺼기도 삭제
rm -rf ~/.moltbot

# 4. 삭제 확인
ls ~/.openclaw
# "No such file or directory" 나오면 성공

# 5. 다시 온보딩 (Chapter 6 참고)
openclaw onboard \
  --non-interactive \
  --accept-risk \
  --auth-choice custom-api-key \
  --custom-base-url "https://api.fireworks.ai/inference/v1" \
  --custom-api-key "YOUR_FIREWORKS_API_KEY" \
  --custom-model-id "accounts/fireworks/models/glm-5" \
  --custom-compatibility openai \
  --gateway-bind loopback \
  --skip-channels \
  --skip-skills \
  --skip-ui \
  --install-daemon

# 6. 컨텍스트 윈도우 수정 (잊지 마세요!)
openclaw config set models.providers.custom-api-fireworks-ai.models.0.contextWindow 200000
openclaw config set models.providers.custom-api-fireworks-ai.models.0.maxTokens 8192
openclaw gateway restart
```

---

## 에러 2: `gateway token missing`

```
❌ disconnected (1008): unauthorized: gateway token missing
```

**무슨 뜻인가요?**

대시보드 URL에 인증 토큰이 빠져있습니다.

**해결 방법:**

```bash
# 이 명령어로 토큰이 포함된 URL을 얻으세요
openclaw dashboard
```

출력되는 URL을 그대로 브라우저에 넣으세요:
```
http://127.0.0.1:18789/#token=a1b2c3d4e5f6...
```

> `http://127.0.0.1:18789/` 만 접속하면 토큰이 없어서 에러가 납니다. 반드시 `#token=...` 부분이 포함된 URL로 접속하세요.

---

## 에러 3: `Model context window too small`

```
❌ blocked model (context window too small): ctx=4096 (min=16000)
```

**무슨 뜻인가요?**

AI 모델의 컨텍스트 윈도우가 너무 작게 설정되어 있습니다. OpenClaw는 최소 16,000이 필요합니다.

**해결 방법:**

```bash
openclaw config set models.providers.custom-api-fireworks-ai.models.0.contextWindow 200000
openclaw config set models.providers.custom-api-fireworks-ai.models.0.maxTokens 8192
openclaw gateway restart
```

---

## 에러 4: `gateway.bind: Invalid input`

```
❌ gateway.bind: Invalid input
```

**무슨 뜻인가요?**

`gateway.bind` 설정에 잘못된 값이 들어있습니다. IP 주소(`0.0.0.0`)는 사용할 수 없습니다.

**사용 가능한 값:**

| 값 | 의미 |
|---|------|
| `loopback` | 이 컴퓨터에서만 접속 (가장 안전) |
| `lan` | 같은 네트워크 내에서 접속 가능 |
| `tailnet` | Tailscale VPN으로 접속 |
| `auto` | 자동 감지 |

**해결 방법:**

```bash
openclaw config set gateway.bind loopback
openclaw gateway restart
```

---

## 에러 5: `Unrecognized keys` (설정 파일 에러)

```
❌ models.providers.custom-api-fireworks-ai: Unrecognized keys: "name", "compatibility"
```

**무슨 뜻인가요?**

설정 파일에 OpenClaw이 인식하지 못하는 항목이 있습니다.

**해결 방법:**

```bash
openclaw doctor --fix
```

이 명령어가 자동으로 잘못된 항목을 찾아서 제거해줍니다.

---

## 에러 6: 채팅을 보냈는데 응답이 안 올 때

**확인 순서:**

```bash
# 1. 게이트웨이가 실행 중인지 확인
openclaw status

# 2. 실시간 로그 확인
openclaw logs --follow
```

로그를 보면서 채팅을 다시 보내보세요. 에러 메시지가 나오면 그걸 기반으로 해결하면 됩니다.

**일반적인 원인:**
- 게이트웨이가 꺼져 있음 → `openclaw gateway start`
- API 키가 잘못됨 → `.env` 파일의 키 확인
- 컨텍스트 윈도우 미수정 → [에러 3](#에러-3-model-context-window-too-small) 참고

---

## 만능 해결법: 자동 진단

뭐가 문제인지 모르겠으면 이것부터 실행하세요:

```bash
openclaw doctor --fix
```

OpenClaw이 자동으로 문제를 찾아서 고쳐줍니다.

---

# Chapter 11. 다른 AI 모델로 바꾸기

GLM-5 외에도 다양한 모델을 사용할 수 있습니다.

## ChatGPT Pro 구독으로 바꾸기

ChatGPT Plus($20/월) 또는 Pro($200/월) 구독이 있다면:

```bash
# 1. 기존 설정 초기화
openclaw gateway stop
openclaw uninstall --all --non-interactive --yes

# 2. ChatGPT 인증으로 온보딩
openclaw onboard \
  --auth-choice openai-codex \
  --gateway-bind loopback \
  --skip-channels \
  --skip-skills \
  --skip-ui \
  --install-daemon
```

브라우저가 열리면 ChatGPT 계정으로 로그인하세요.

**결과:**
- 모델: `gpt-5.3-codex` (272k context)
- 비용: 구독료 외 추가 비용 없음

## 다시 GLM-5로 돌아가기

```bash
# 1. 기존 설정 초기화
openclaw gateway stop
openclaw uninstall --all --non-interactive --yes

# 2. Fireworks AI로 온보딩
openclaw onboard \
  --non-interactive \
  --accept-risk \
  --auth-choice custom-api-key \
  --custom-base-url "https://api.fireworks.ai/inference/v1" \
  --custom-api-key "YOUR_FIREWORKS_API_KEY" \
  --custom-model-id "accounts/fireworks/models/glm-5" \
  --custom-compatibility openai \
  --gateway-bind loopback \
  --skip-channels \
  --skip-skills \
  --skip-ui \
  --install-daemon

# 3. 컨텍스트 윈도우 수정 (필수!)
openclaw config set models.providers.custom-api-fireworks-ai.models.0.contextWindow 200000
openclaw config set models.providers.custom-api-fireworks-ai.models.0.maxTokens 8192
openclaw gateway restart
```

## 사용 가능한 인증 방식 목록

| auth-choice | 설명 | API 키 필요 |
|-------------|------|------------|
| `openai-codex` | ChatGPT 구독 (OAuth) | 아니요 |
| `openai-api-key` | OpenAI API | 예 |
| `custom-api-key` | 커스텀 (Fireworks 등) | 예 |
| `gemini-api-key` | Google Gemini | 예 |
| `together-api-key` | Together AI | 예 |
| `openrouter-api-key` | OpenRouter | 예 |

---

# Chapter 12. 비용 가이드

## 모델별 가격 비교 (100만 토큰당)

| 모델 | 입력(Input) | 출력(Output) | 특징 |
|------|------------|-------------|------|
| GLM-5 (Fireworks) | $0.80 | $2.56 | 저렴, 200k 컨텍스트 |
| GLM-4 Plus (Fireworks) | $0.60 | $2.20 | 더 저렴, 128k 컨텍스트 |
| DeepSeek V3.2 (Together) | $0.55 | $2.19 | 최저가급 |
| GPT-4o (OpenAI) | $2.50 | $10.00 | OpenAI 직접 |
| Gemini 2.5 Flash-Lite | $0.50 | $0.50 | Google, 무료 티어 있음 |

> **100만 토큰이 얼마나 되나요?**
>
> 일반적인 대화에서:
> - 한 번의 질문+답변 ≈ 500~2,000 토큰
> - 100만 토큰 ≈ 하루 30~50번 대화 × 한 달

## 월간 예상 비용

| 사용 패턴 | ChatGPT Plus | GLM-5 (Fireworks) | Gemini Flash |
|-----------|-------------|-------------------|-------------|
| 가벼운 사용 (하루 5~10번) | $20 (정액) | ~$3 | ~$1 |
| 보통 사용 (하루 20~30번) | $20 (정액) | ~$15 | ~$5 |
| 헤비 사용 (하루 50번+) | $20 (정액) | ~$50 | ~$15 |

### Railway 호스팅 비용 (24시간 운영 시)

| 항목 | 월 비용 |
|------|---------|
| Railway Hobby 플랜 | $5 |
| 서버 사용량 (CPU/RAM) | ~$5 |
| **호스팅 소계** | **~$10** |

### 총 비용 예시

| 구성 | 월 비용 |
|------|---------|
| Railway + GLM-5 (가벼운 사용) | ~$13 |
| Railway + GLM-5 (보통 사용) | ~$25 |
| 로컬만 + GLM-5 (가벼운 사용) | ~$3 |
| 로컬만 + ChatGPT Plus | $20 |

> **가장 저렴한 조합**: 로컬 실행 + GLM-5 → 월 $3~$15
> **24시간 운영**: Railway + GLM-5 → 월 $13~$25

---

# Chapter 13. 데이터 프라이버시 - 내 데이터는 안전한가?

AI를 사용할 때 가장 중요한 질문입니다.

## 중국 모델 직접 API = 위험

중국 AI 회사의 API를 **직접** 사용하면 데이터가 **중국 서버**로 전송됩니다.

| 프로바이더 | 데이터 위치 | 안전한가? |
|-----------|------------|----------|
| DeepSeek 직접 API | 중국 (항저우) | ❌ 사용 금지 |
| Kimi (Moonshot) 직접 API | 중국 | ❌ 사용 금지 |
| Qwen (Alibaba) 직접 API | 중국 | ❌ 사용 금지 |
| GLM (Zhipu) 직접 API | 중국 | ❌ 사용 금지 |

## 이 가이드의 방법 = 안전

| 방법 | 데이터 위치 | 안전한가? |
|------|------------|----------|
| Fireworks AI 경유 | 미국 서버 | ✅ 안전 |
| Together AI 경유 | 미국 서버 | ✅ 안전 |
| OpenRouter 경유 | 미국/EU 서버 | ✅ 안전 |
| OpenAI (ChatGPT) | 미국 서버 | ✅ 안전 |
| 로컬 모델 (Ollama) | 내 컴퓨터 | ✅ 가장 안전 |

## 왜 Fireworks AI는 안전한가?

1. **Fireworks AI는 미국 회사**입니다 (샌프란시스코 소재)
2. 중국 모델(GLM-5)의 **가중치(weights)만** 가져와서 미국 서버에서 실행
3. 여러분의 대화 데이터는 **미국 서버에서만 처리**
4. 중국으로 데이터가 전송되는 경로 자체가 없음

```
여러분의 대화 → Fireworks AI (미국 서버) → AI 응답
                     ✅ 여기서 끝!
                     ❌ 중국으로 안 감
```

## 핵심 원칙 3가지

1. **중국 모델을 쓰되, 반드시 미국/EU 호스팅 프로바이더를 경유하세요**
2. **민감한 데이터는 로컬 모델(Ollama) 사용을 권장합니다**
3. **직접 중국 API 엔드포인트에 요청하지 마세요**

---

# Chapter 14. 명령어 치트시트

자주 쓰는 명령어를 한 곳에 모았습니다. 이 페이지를 북마크 해두세요!

## 설치 & 설정

```bash
# OpenClaw CLI 설치
npm install -g openclaw@latest

# 온보딩 (초기 설정)
openclaw onboard

# 자동 진단 & 수리
openclaw doctor --fix
```

## 게이트웨이 관리

```bash
# 상태 확인 (가장 많이 쓰는 명령어!)
openclaw status

# 시작 / 중지 / 재시작
openclaw gateway start
openclaw gateway stop
openclaw gateway restart

# 대시보드 열기 (토큰 포함 URL)
openclaw dashboard

# 실시간 로그 보기
openclaw logs --follow
```

## 설정 변경

```bash
# 설정값 확인
openclaw config get agents.defaults.model
openclaw config get gateway.auth.token

# 설정값 변경
openclaw config set KEY VALUE

# 모델 목록 보기
openclaw models

# 모델 변경
openclaw models set PROVIDER/MODEL_ID
```

## 초기화 & 재설정

```bash
# 게이트웨이만 중지
openclaw gateway stop

# 전체 삭제 (CLI는 유지)
openclaw uninstall --all --non-interactive --yes

# 레거시 폴더 삭제
rm -rf ~/.moltbot

# 다시 온보딩
openclaw onboard ...
```

## 서버 실행

```bash
# 프로젝트 폴더에서
cd hey-jarvis

# 서버 시작
pnpm start

# 헬스체크
curl http://localhost:8080/healthz
```

---

# 부록 A. 전체 프로젝트 파일 모음

최종 완성된 모든 파일을 한 곳에 모았습니다.

## 폴더 구조

```
hey-jarvis/
├── .env.example
├── .gitignore
├── Dockerfile
├── entrypoint.sh
├── openclaw.json
├── package.json
├── railway.toml
└── src/
    └── server.js
```

## .env.example

```env
# === 필수 ===
FIREWORKS_API_KEY=your-fireworks-api-key-here
SETUP_PASSWORD=changeme
PORT=8080
```

## .gitignore

```
node_modules/
.cache/
.env
/data/
*.log
```

## Dockerfile

```dockerfile
FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN corepack enable && corepack prepare pnpm@latest --activate

RUN npm install -g openclaw@latest

WORKDIR /app

COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --frozen-lockfile 2>/dev/null || pnpm install

COPY . .

RUN chmod +x entrypoint.sh

RUN groupadd -r openclaw && useradd -r -g openclaw -m openclaw

RUN mkdir -p /data/.openclaw /data/workspace && \
    chown -R openclaw:openclaw /data /app

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
```

## entrypoint.sh

```bash
#!/bin/bash
set -e

mkdir -p /data/.openclaw /data/workspace

if [ ! -f /data/.openclaw/openclaw.json ]; then
  echo "No config found. Copying default config..."
  cp /app/openclaw.json /data/.openclaw/openclaw.json
fi

chown -R openclaw:openclaw /data

export OPENCLAW_STATE_DIR=/data/.openclaw
export OPENCLAW_WORKSPACE_DIR=/data/workspace
export HOME=/home/openclaw

exec su -s /bin/bash openclaw -c "node /app/src/server.js"
```

## openclaw.json

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "custom-api-fireworks-ai/accounts/fireworks/models/glm-5"
      }
    }
  },
  "gateway": {
    "mode": "local",
    "port": 18789,
    "bind": "loopback"
  }
}
```

## package.json

```json
{
  "name": "hey-jarvis",
  "version": "1.0.0",
  "private": true,
  "description": "OpenClaw gateway with Fireworks AI + GLM-5",
  "scripts": {
    "start": "node src/server.js",
    "dev": "node src/server.js"
  },
  "dependencies": {
    "dotenv": "^17.3.1",
    "express": "^5.1.0",
    "http-proxy": "^1.18.1",
    "ws": "^8.18.0"
  },
  "engines": {
    "node": ">=22"
  }
}
```

## railway.toml

```toml
[build]
builder = "dockerfile"

[deploy]
healthcheckPath = "/healthz"
healthcheckTimeout = 300
restartPolicyType = "on_failure"
restartPolicyMaxRetries = 5
```

## src/server.js

```javascript
require("dotenv").config();

const express = require("express");
const http = require("http");
const httpProxy = require("http-proxy");
const { spawn } = require("child_process");
const fs = require("fs");
const path = require("path");

const PORT = parseInt(process.env.PORT || "8080", 10);
const GATEWAY_PORT = 18789;
const SETUP_PASSWORD = process.env.SETUP_PASSWORD || "";
const STATE_DIR =
  process.env.OPENCLAW_STATE_DIR ||
  path.join(process.env.HOME || "/home/openclaw", ".openclaw");
const CONFIG_PATH = path.join(STATE_DIR, "openclaw.json");

let gatewayProcess = null;
let gatewayReady = false;

// --- Config ---

function buildConfig() {
  const apiKey = process.env.FIREWORKS_API_KEY;
  if (!apiKey) return null;

  return {
    agents: {
      defaults: {
        model: {
          primary:
            "custom-api-fireworks-ai/accounts/fireworks/models/glm-5",
        },
      },
    },
    models: {
      providers: {
        "custom-api-fireworks-ai": {
          baseUrl: "https://api.fireworks.ai/inference/v1",
          apiKey: apiKey,
          models: [
            {
              id: "accounts/fireworks/models/glm-5",
              name: "GLM-5 (Fireworks)",
              contextWindow: 200000,
              maxTokens: 8192,
            },
          ],
        },
      },
    },
    gateway: {
      mode: "local",
      port: GATEWAY_PORT,
      bind: "loopback",
    },
  };
}

function ensureConfig() {
  fs.mkdirSync(STATE_DIR, { recursive: true });

  const config = buildConfig();
  if (config) {
    fs.writeFileSync(CONFIG_PATH, JSON.stringify(config, null, 2));
    console.log("[hey-jarvis] Generated config from FIREWORKS_API_KEY.");
    return;
  }

  if (!fs.existsSync(CONFIG_PATH)) {
    const tpl = path.join(__dirname, "..", "openclaw.json");
    if (fs.existsSync(tpl)) {
      fs.copyFileSync(tpl, CONFIG_PATH);
      console.log("[hey-jarvis] Copied default config template.");
    }
  }
}

// --- Gateway Process Management ---

function startGateway() {
  console.log("[hey-jarvis] Starting OpenClaw gateway...");

  gatewayProcess = spawn(
    "openclaw",
    [
      "gateway",
      "run",
      "--port",
      String(GATEWAY_PORT),
      "--bind",
      "loopback",
      "--allow-unconfigured",
    ],
    {
      env: {
        ...process.env,
        OPENCLAW_STATE_DIR: STATE_DIR,
        OPENCLAW_CONFIG_PATH: CONFIG_PATH,
        OPENCLAW_WORKSPACE_DIR:
          process.env.OPENCLAW_WORKSPACE_DIR || "/data/workspace",
      },
      stdio: ["pipe", "pipe", "pipe"],
    }
  );

  gatewayProcess.stdout.on("data", (data) => {
    const msg = data.toString().trim();
    console.log(`[gateway] ${msg}`);
    if (
      msg.includes("listening") ||
      msg.includes("ready") ||
      msg.includes("Gateway")
    ) {
      gatewayReady = true;
      console.log("[hey-jarvis] Gateway is ready.");
    }
  });

  gatewayProcess.stderr.on("data", (data) => {
    const msg = data.toString().trim();
    if (msg) console.error(`[gateway:err] ${msg}`);
    if (msg.includes("listening") || msg.includes("ready")) {
      gatewayReady = true;
    }
  });

  gatewayProcess.on("exit", (code) => {
    console.log(`[hey-jarvis] Gateway exited with code ${code}`);
    gatewayReady = false;
    setTimeout(() => {
      console.log("[hey-jarvis] Restarting gateway...");
      startGateway();
    }, 3000);
  });

  setTimeout(() => {
    if (!gatewayReady) {
      gatewayReady = true;
      console.log("[hey-jarvis] Gateway assumed ready (timeout).");
    }
  }, 15000);
}

// --- Express App ---

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/healthz", (_req, res) => {
  res.json({
    status: "ok",
    gateway: gatewayReady ? "running" : "starting",
    timestamp: new Date().toISOString(),
  });
});

app.get("/setup/healthz", (_req, res) => res.json({ status: "ok" }));

// --- WebSocket Proxy to Gateway ---

const proxy = httpProxy.createProxyServer({
  target: `http://127.0.0.1:${GATEWAY_PORT}`,
  ws: true,
});

proxy.on("error", (err, _req, res) => {
  console.error("[proxy]", err.message);
  if (res && res.writeHead) {
    res.writeHead(502, { "Content-Type": "application/json" });
    res.end(JSON.stringify({ error: "Gateway not ready" }));
  }
});

app.use((req, res) => {
  if (!gatewayReady) {
    return res.status(503).json({ error: "Gateway starting" });
  }
  proxy.web(req, res);
});

// --- Start ---

const server = http.createServer(app);

server.on("upgrade", (req, socket, head) => {
  if (gatewayReady) {
    proxy.ws(req, socket, head);
  } else {
    socket.destroy();
  }
});

ensureConfig();

server.listen(PORT, "0.0.0.0", () => {
  console.log(`[hey-jarvis] Listening on :${PORT}`);
  startGateway();
});

process.on("SIGTERM", () => {
  console.log("[hey-jarvis] Shutting down...");
  if (gatewayProcess) gatewayProcess.kill("SIGTERM");
  server.close(() => process.exit(0));
});
```

---

# 부록 B. 용어 사전

| 용어 | 설명 |
|------|------|
| **API** | Application Programming Interface. 프로그램끼리 대화하는 규격. 식당의 메뉴판 같은 것. |
| **API 키** | API를 사용하기 위한 비밀번호. 열쇠 같은 것. |
| **CLI** | Command Line Interface. 터미널에서 텍스트로 조작하는 방식. |
| **컨텍스트 윈도우** | AI가 한 번에 기억할 수 있는 텍스트 양. 200k = 책 한 권 분량. |
| **Docker** | 프로그램을 하나의 박스(컨테이너)로 포장하는 기술. |
| **환경변수 (.env)** | 비밀번호, API 키 등을 코드와 분리해서 저장하는 파일. |
| **Express** | Node.js용 웹 서버 프레임워크. 가장 널리 쓰이는 도구. |
| **게이트웨이** | 요청을 받아서 적절한 곳으로 전달하는 중간 다리. |
| **Git** | 코드 버전을 관리하는 도구. 파일의 타임머신. |
| **GitHub** | Git으로 관리하는 코드를 온라인에 저장하는 서비스. |
| **GLM-5** | Zhipu AI가 만든 대규모 AI 모델. 744B 파라미터. |
| **Homebrew** | macOS용 패키지 관리자. 앱스토어의 개발자 버전. |
| **LaunchAgent** | macOS에서 프로그램을 자동으로 시작하는 시스템 서비스. |
| **Node.js** | JavaScript를 서버에서 실행할 수 있게 해주는 프로그램. |
| **npm** | Node.js의 패키지 관리자. 도구를 설치할 때 사용. |
| **온보딩** | 처음 사용할 때 하는 초기 설정 과정. |
| **OpenClaw** | 오픈소스 AI 비서 게이트웨이. 이 책의 핵심 도구. |
| **pnpm** | npm보다 빠른 패키지 관리자. |
| **포트** | 컴퓨터에서 네트워크 서비스가 사용하는 번호. 아파트 호수 같은 것. |
| **프록시** | 요청을 대신 전달해주는 중간 서버. |
| **Railway** | 서버를 쉽게 배포할 수 있는 클라우드 서비스. |
| **토큰** | AI에서 텍스트를 처리하는 단위. 한글 한 글자 ≈ 2~3 토큰. |
| **Volume** | 서버가 재시작되어도 데이터가 유지되는 저장 공간. |
| **WebSocket** | 서버와 브라우저가 실시간으로 양방향 통신하는 기술. |
