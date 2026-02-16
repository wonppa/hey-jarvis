# Hey Jarvis - OpenClaw Setup Guide

> OpenClaw 개인 AI 비서를 로컬 + Railway에 배포하는 완전 가이드

## 목차

1. [개요](#1-개요)
2. [사전 준비](#2-사전-준비)
3. [로컬 설치](#3-로컬-설치)
4. [인증 방식 선택](#4-인증-방식-선택)
5. [모델 프로바이더 설정](#5-모델-프로바이더-설정)
6. [게이트웨이 실행 및 확인](#6-게이트웨이-실행-및-확인)
7. [Railway 배포](#7-railway-배포)
8. [트러블슈팅](#8-트러블슈팅)
9. [비용 비교](#9-비용-비교)
10. [데이터 프라이버시 주의사항](#10-데이터-프라이버시-주의사항)

---

## 1. 개요

### OpenClaw란?

OpenClaw(구 Clawdbot/Moltbot)은 오픈소스 개인 AI 비서 게이트웨이입니다. WhatsApp, Telegram, Slack, Discord 등 다양한 채널과 연동되며, 자체 서버에서 실행하여 AI 모델에 대한 완전한 제어권을 가집니다.

### 이 프로젝트 구성

```
hey-jarvis/
├── Dockerfile          # Railway 배포용 Docker 이미지
├── entrypoint.sh       # 컨테이너 시작 스크립트
├── railway.toml        # Railway 배포 설정
├── package.json        # Node.js 의존성
├── pnpm-lock.yaml      # 락파일
├── openclaw.json       # 기본 OpenClaw 설정 (Fireworks AI + GLM-5)
├── .env.example        # 환경변수 템플릿
├── .gitignore
└── src/
    └── server.js       # Express 래퍼 서버 (셋업 위저드 + 게이트웨이 프록시)
```

### 아키텍처

```
[클라이언트] → [:8080 Express 래퍼] → [:18789 OpenClaw 게이트웨이] → [AI 모델 API]
                  ├── /healthz (헬스체크)
                  ├── /setup (설정 위저드)
                  └── /* (게이트웨이 프록시)
```

---

## 2. 사전 준비

### 필수 소프트웨어

| 소프트웨어 | 최소 버전 | 설치 명령어 |
|-----------|----------|------------|
| Node.js | 22+ | `brew install node` |
| pnpm | 8+ | `npm install -g pnpm` |
| OpenClaw | 2026.2.14+ | `npm install -g openclaw@latest` |

### 설치 확인

```bash
node --version        # v22 이상
openclaw --version    # 2026.2.14 이상
```

### AI 모델 접근 (택 1)

| 방식 | 필요한 것 | 월 비용 |
|------|----------|---------|
| ChatGPT Pro 구독 | ChatGPT Plus/Pro 계정 | $20/$200 (기존 구독) |
| Fireworks API | Fireworks AI API 키 | 사용량 기반 (~$5-25) |
| OpenAI API | OpenAI API 키 | 사용량 기반 |

---

## 3. 로컬 설치

### 3.1 OpenClaw CLI 설치

```bash
npm install -g openclaw@latest
```

### 3.2 프로젝트 클론 및 의존성 설치

```bash
cd hey-jarvis
pnpm install
```

### 3.3 환경변수 설정

```bash
cp .env.example .env
```

`.env` 파일 편집:

```env
# === Required ===
SETUP_PASSWORD=changeme
PORT=8080

# === Fireworks AI 사용 시 ===
FIREWORKS_API_KEY=fw_your_key_here

# === OpenAI API 사용 시 ===
OPENAI_API_KEY=sk-your_key_here
```

> ChatGPT Pro 구독 인증 시에는 API 키가 필요 없습니다 (OAuth 방식).

---

## 4. 인증 방식 선택

### 방식 A: ChatGPT Pro 구독 (OAuth) - 추가 비용 없음

ChatGPT Plus($20/월) 또는 Pro($200/월) 구독이 있다면 API 키 없이 OAuth 인증으로 사용 가능합니다.

```bash
openclaw onboard \
  --auth-choice openai-codex \
  --gateway-bind loopback \
  --skip-channels \
  --skip-skills \
  --skip-ui \
  --install-daemon
```

브라우저가 열리면 ChatGPT 계정으로 로그인합니다.

**결과:**
- 모델: `gpt-5.3-codex` (272k context)
- 비용: 구독료 외 추가 비용 없음
- 인증: OAuth (자동 토큰 갱신)

### 방식 B: Fireworks AI + GLM-5 (저비용 API)

중국 Zhipu AI의 GLM-5 모델을 미국 Fireworks AI 서버를 경유하여 사용합니다.

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

**중요: 컨텍스트 윈도우 수정 필수**

onboard가 기본값을 4096으로 설정하는데, GLM-5는 200k를 지원합니다. 반드시 수정해야 합니다:

```bash
openclaw config set models.providers.custom-api-fireworks-ai.models.0.contextWindow 200000
openclaw config set models.providers.custom-api-fireworks-ai.models.0.maxTokens 8192
openclaw gateway restart
```

이 수정을 하지 않으면 `Model context window too small (4096 tokens). Minimum is 16000.` 에러가 발생합니다.

**결과:**
- 모델: GLM-5 (200k context)
- 비용: ~$0.80/$2.56 per 1M tokens
- 데이터: 미국 서버에서만 처리 (중국 전송 없음)

### 방식 C: OpenAI API 키

```bash
openclaw onboard \
  --non-interactive \
  --accept-risk \
  --auth-choice openai-api-key \
  --openai-api-key "sk-YOUR_KEY" \
  --gateway-bind loopback \
  --skip-channels \
  --skip-skills \
  --skip-ui \
  --install-daemon
```

### 온보딩 리셋 (재설정 필요 시)

기존 설정을 완전히 초기화하고 다시 시작:

```bash
# 1. 게이트웨이 중지
openclaw gateway stop

# 2. 전체 삭제 (CLI는 유지)
openclaw uninstall --all --non-interactive --yes

# 3. 삭제 확인
ls ~/.openclaw  # "No such file or directory" 나오면 성공

# 4. 원하는 방식으로 다시 onboard
openclaw onboard ...
```

---

## 5. 모델 프로바이더 설정

### 설정 파일 위치

```
~/.openclaw/openclaw.json
```

### Fireworks AI 수동 설정 예시

`openclaw.json`에 직접 프로바이더를 추가하는 경우:

```json
{
  "models": {
    "mode": "merge",
    "providers": {
      "fireworks": {
        "baseUrl": "https://api.fireworks.ai/inference/v1",
        "apiKey": "fw_your_key",
        "api": "openai-completions",
        "models": [
          {
            "id": "accounts/fireworks/models/glm-5",
            "name": "GLM-5",
            "reasoning": true,
            "input": ["text"],
            "cost": { "input": 0.8, "output": 2.56 },
            "contextWindow": 200000,
            "maxTokens": 8192
          },
          {
            "id": "accounts/fireworks/models/glm-4-plus",
            "name": "GLM-4 Plus",
            "reasoning": false,
            "input": ["text"],
            "cost": { "input": 0.6, "output": 2.2 },
            "contextWindow": 128000,
            "maxTokens": 8192
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "fireworks/accounts/fireworks/models/glm-5",
        "fallbacks": ["fireworks/accounts/fireworks/models/glm-4-plus"]
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

### 설정 명령어 모음

```bash
# 현재 모델 확인
openclaw config get agents.defaults.model

# 모델 변경
openclaw models set fireworks/accounts/fireworks/models/glm-4-plus

# 프로바이더 설정값 확인
openclaw config get models.providers

# 게이트웨이 인증 토큰 확인
openclaw config get gateway.auth.token
```

### 사용 가능한 auth-choice 목록

| auth-choice | 설명 | API 키 필요 |
|-------------|------|------------|
| `openai-codex` | ChatGPT 구독 OAuth | No |
| `openai-api-key` | OpenAI API | Yes |
| `custom-api-key` | 커스텀 프로바이더 (Fireworks 등) | Yes |
| `gemini-api-key` | Google Gemini | Yes |
| `anthropic-api-key` (setup-token) | Claude 구독 | No |
| `together-api-key` | Together AI | Yes |
| `openrouter-api-key` | OpenRouter | Yes |
| `zai-api-key` | Z.AI (GLM 공식) | Yes |

---

## 6. 게이트웨이 실행 및 확인

### 6.1 게이트웨이 시작

onboard 시 `--install-daemon`을 사용했다면 LaunchAgent로 자동 실행됩니다.

```bash
# 상태 확인
openclaw status

# 수동 시작 (포그라운드)
openclaw gateway run --port 18789 --bind loopback

# 서비스로 시작/중지/재시작
openclaw gateway start
openclaw gateway stop
openclaw gateway restart
```

### 6.2 대시보드 접속

```bash
openclaw dashboard
```

토큰이 포함된 URL로 브라우저가 자동으로 열립니다:
```
http://127.0.0.1:18789/#token=YOUR_GATEWAY_TOKEN
```

> 시크릿 윈도우에서 열면 이전 세션 토큰 충돌을 피할 수 있습니다.

### 6.3 상태 확인 체크리스트

```bash
openclaw status
```

정상 상태 예시:
```
Gateway: local · ws://127.0.0.1:18789 · reachable 32ms
Gateway service: LaunchAgent installed · loaded · running
Sessions: default gpt-5.3-codex (272k ctx)
```

### 6.4 로그 확인

```bash
# 실시간 로그
openclaw logs --follow

# 최근 로그
openclaw logs
```

---

## 7. Railway 배포

### 7.1 사전 조건

- Railway 계정 (https://railway.com)
- GitHub에 hey-jarvis 레포 푸시

### 7.2 배포 과정

1. Railway 대시보드에서 **New Project > Deploy from GitHub Repo**
2. `hey-jarvis` 디렉토리 선택
3. **Volume 추가**: Mount path `/data`

### 7.3 환경변수 설정 (Railway 대시보드)

```
PORT=8080
SETUP_PASSWORD=your_secure_password
FIREWORKS_API_KEY=fw_your_key
```

> ChatGPT OAuth는 브라우저 플로우가 필요하므로 Railway에서는 API 키 방식(Fireworks/OpenAI)을 사용해야 합니다.

### 7.4 Railway 설정 파일

`railway.toml`:
```toml
[build]
builder = "dockerfile"

[deploy]
healthcheckPath = "/healthz"
healthcheckTimeout = 300
restartPolicyType = "on_failure"
restartPolicyMaxRetries = 5
```

### 7.5 배포 후 확인

```bash
# 헬스체크
curl https://your-app.railway.app/healthz

# 설정 위저드
open https://your-app.railway.app/setup
```

### 7.6 Railway 래퍼 서버 동작 방식

`src/server.js`가 하는 일:

1. `dotenv`로 `.env` 파일 로드
2. `FIREWORKS_API_KEY` 환경변수가 있으면 `openclaw.json` 자동 생성
3. Express 서버를 `:8080`에서 시작
4. OpenClaw 게이트웨이를 `:18789`에서 자식 프로세스로 시작
5. `/healthz` → 헬스체크 응답
6. `/setup` → 웹 UI 설정 위저드
7. 나머지 HTTP/WebSocket → 게이트웨이로 프록시
8. 게이트웨이 크래시 시 3초 후 자동 재시작

### 7.7 예상 비용 (Railway)

| 항목 | 비용 |
|------|------|
| Railway Hobby 플랜 | $5/월 |
| Railway 사용량 | ~$5/월 |
| Fireworks API (GLM-5) | ~$5-25/월 |
| **합계** | **$15-35/월** |

---

## 8. 트러블슈팅

### `device token mismatch` 에러

**증상:**
```
disconnected (1008): unauthorized: device token mismatch (rotate/reissue device token)
```

**원인:** 이전 세션의 디바이스 토큰이 브라우저 로컬스토리지에 캐시되어 있음

**해결:**
1. 브라우저 시크릿 윈도우에서 접속
2. 또는 DevTools > Application > Local Storage > `127.0.0.1:18789` 전부 삭제
3. `openclaw dashboard` 명령어로 토큰 포함된 URL로 접속
4. 최후의 수단: 완전 리셋

```bash
openclaw gateway stop
openclaw uninstall --all --non-interactive --yes
openclaw onboard ...  # 처음부터 다시
```

### `gateway token missing` 에러

**증상:**
```
disconnected (1008): unauthorized: gateway token missing
```

**해결:**
```bash
# 토큰 확인
openclaw config get gateway.auth.token

# 토큰 포함 URL로 대시보드 열기
openclaw dashboard
```

### `Model context window too small` 에러

**증상:**
```
blocked model (context window too small): ctx=4096 (min=16000)
```

**원인:** onboard가 커스텀 모델의 contextWindow를 4096으로 기본 설정

**해결:**
```bash
openclaw config set models.providers.custom-api-fireworks-ai.models.0.contextWindow 200000
openclaw config set models.providers.custom-api-fireworks-ai.models.0.maxTokens 8192
openclaw gateway restart
```

### `gateway.bind: Invalid input` 에러

**원인:** bind 값에 IP 주소(`0.0.0.0`)를 넣음

**해결:** 유효한 bind 모드 사용
- `loopback` - 로컬 전용 (127.0.0.1)
- `lan` - 로컬 네트워크
- `tailnet` - Tailscale 네트워크
- `auto` - 자동 감지
- `custom` - 커스텀 설정

### `gateway closed (1006 abnormal closure)` 에러

**원인:** 게이트웨이가 실행 중이지 않음

**해결:**
```bash
openclaw gateway start
# 또는
openclaw gateway run --port 18789 --bind loopback
```

### 설정 꼬였을 때 완전 초기화

```bash
# 1. 게이트웨이 중지
openclaw gateway stop

# 2. 전체 삭제
openclaw uninstall --all --non-interactive --yes

# 3. 이전 디렉토리도 삭제 (.moltbot 레거시)
rm -rf ~/.moltbot

# 4. 확인
ls ~/.openclaw  # "No such file or directory"

# 5. 다시 온보딩
openclaw onboard ...
```

### doctor로 진단

```bash
openclaw doctor --fix
```

자동으로 감지되는 문제를 수정해줍니다.

---

## 9. 비용 비교

### 모델별 비용 (1M 토큰 기준)

| 모델 | Input | Output | 비고 |
|------|-------|--------|------|
| GPT-5.3 (ChatGPT Pro 구독) | 포함 | 포함 | $200/월 구독 |
| GPT-5.3 (ChatGPT Plus 구독) | 포함 | 포함 | $20/월 구독 |
| GLM-5 (Fireworks) | $0.80 | $2.56 | 미국 서버 |
| GLM-4 Plus (Fireworks) | $0.60 | $2.20 | 미국 서버 |
| DeepSeek V3.2 (Together) | $0.55 | $2.19 | 미국 서버 |
| Gemini 2.5 Flash-Lite | $0.50 | $0.50 | 무료 티어 있음 |

### 월간 비용 시나리오

| 사용 패턴 | ChatGPT 구독 | Fireworks GLM-5 | Gemini Flash |
|-----------|-------------|-----------------|-------------|
| 가벼운 사용 (1M tokens/월) | $20 (Plus) | ~$3 | ~$1 |
| 보통 사용 (10M tokens/월) | $20 (Plus) | ~$30 | ~$10 |
| 헤비 사용 (50M tokens/월) | $200 (Pro) | ~$150 | ~$50 |

> ChatGPT 구독은 사용량에 무관하게 정액이므로 헤비 유저에게 유리합니다.

---

## 10. 데이터 프라이버시 주의사항

### 중국 모델 직접 API 사용 금지

| 프로바이더 | 데이터 위치 | GDPR | 판정 |
|-----------|------------|------|------|
| DeepSeek 직접 API | 중국 (항저우) | 미준수 | 사용 금지 |
| Kimi (Moonshot) 직접 API | 중국 | 미준수 | 사용 금지 |
| Qwen (Alibaba) 직접 API | 중국 | 미준수 | 사용 금지 |
| GLM (Zhipu) 직접 API | 중국 | 불명확 | 사용 금지 |

### 안전한 사용 방법

| 방법 | 데이터 위치 | 안전도 |
|------|------------|--------|
| Fireworks AI 경유 | 미국 | 안전 |
| Together AI 경유 | 미국 | 안전 |
| OpenRouter 경유 | 미국/EU | 안전 |
| Ollama 로컬 | 내 컴퓨터 | 가장 안전 |
| 중국 프로바이더 직접 | 중국 | 위험 |

> Fireworks AI, Together AI는 중국 모델(GLM, DeepSeek, Qwen)을 미국 서버에서 호스팅합니다. 같은 모델이지만 데이터가 중국으로 전송되지 않습니다.

### 핵심 원칙

- 중국 모델을 쓰되, **반드시 미국/EU 호스팅 프로바이더 경유**
- 민감한 데이터는 **로컬 모델(Ollama)** 사용 권장
- ChatGPT 구독은 **OpenAI 서버(미국)** 에서 처리되므로 안전

---

## 부록: 주요 명령어 치트시트

```bash
# === 설치/설정 ===
npm install -g openclaw@latest          # CLI 설치
openclaw onboard                        # 대화형 온보딩
openclaw configure                      # 설정 위저드
openclaw doctor --fix                   # 자동 진단/수정

# === 게이트웨이 ===
openclaw gateway start                  # 서비스 시작
openclaw gateway stop                   # 서비스 중지
openclaw gateway restart                # 서비스 재시작
openclaw gateway run                    # 포그라운드 실행
openclaw status                         # 전체 상태 확인
openclaw dashboard                      # 대시보드 열기

# === 설정 ===
openclaw config get gateway.auth.token  # 게이트웨이 토큰 확인
openclaw config get agents.defaults     # 에이전트 기본 설정
openclaw config set KEY VALUE           # 설정값 변경
openclaw models                         # 모델 목록
openclaw models set PROVIDER/MODEL      # 모델 변경

# === 로그/디버깅 ===
openclaw logs                           # 최근 로그
openclaw logs --follow                  # 실시간 로그
openclaw health                         # 헬스체크
openclaw devices list                   # 디바이스 목록

# === 채널 ===
openclaw channels                       # 채널 목록
openclaw configure --section channels   # 채널 설정

# === 리셋 ===
openclaw gateway stop                   # 중지
openclaw uninstall --all --yes          # 전체 삭제
```
