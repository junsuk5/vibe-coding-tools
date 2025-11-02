# Windows용 Flutter 바이브 코딩 환경 설치 스크립트

이 스크립트는 Windows 환경에서 Flutter 바이브 코딩에 필요한 개발 환경을 자동으로 구성합니다.

## 주요 기능

- **Chocolatey 패키지 관리자 확인:** Chocolatey가 설치되어 있는지 확인하고, 미설치 시 설치 방법을 안내합니다.
- **필수 도구 설치:** Git, Node.js, FVM(Flutter Version Manager)을 설치합니다.
- **Flutter SDK 설치:** FVM을 통해 최신 안정 버전의 Flutter SDK를 설치하고 전역 기본값으로 설정합니다.
- **환경 변수 설정:** Flutter 및 Dart 관련 경로를 사용자 PATH 환경 변수에 추가합니다.
- **Firebase & Gemini CLI 설치:** `npm`을 사용하여 Firebase Tools(MCP 포함)와 Gemini CLI를 전역으로 설치합니다.
- **Gemini CLI 설정:** Gemini CLI가 Dart MCP 서버를 사용하도록 자동으로 구성합니다.

## 사용 방법

1.  `install.bat` 파일을 마우스 오른쪽 버튼으로 클릭합니다.
2.  **"관리자 권한으로 실행"** 메뉴를 선택하여 스크립트를 실행합니다.
3.  스크립트가 실행되며 필요한 프로그램들을 설치합니다. 이 과정은 몇 분 정도 소요될 수 있습니다.
4.  설치가 완료되면 스크립트의 안내에 따라 **터미널(명령 프롬프트 또는 PowerShell)을 다시 시작**하여 변경된 환경 변수를 적용합니다.

## 설치 후 단계

스크립트 실행이 완료되고 터미널을 다시 시작한 후, 다음 명령어를 실행하여 최종 설정을 완료하세요.

1.  **Flutter 설정 확인:**
    ```shell
    flutter doctor
    ```
2.  **Gemini CLI 인증:**
    ```shell
    gemini auth login
    ```
3.  **Gemini CLI용 Firebase 확장 프로그램 설치:**
    ```shell
    gemini extensions install firebase
    ```
4.  **MCP 서버 확인 (선택 사항):**
    ```shell
    # Dart MCP 서버 확인
    dart mcp-server --help

    # Firebase MCP 서버 확인
    firebase mcp --help
    ```
