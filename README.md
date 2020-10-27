# dotfiles
My Linux dotfiles and installation scripts

## PPA 주의점
* PPA의 경우 Ubuntu 의 6개월 버전업을 올바로 따라가지 못하는 경우가 많이 발생한다.
* Ubuntu 를 6개월마다 버전업할 예정이고, 해당 패키지가 Ubuntu 에 비록 버전이 뒤지더라도 항상 있는것이라면 가급적 Ubuntu 기본을 사용하는게 낫다.
* 그렇지 않으면, Ubuntu 가 버전업 돼도 PPA가 해당 버전의 신규 패키지를 못 좇아와서 올바로 신규 버전 설치가 안될 수 있다.

## 설치 전 확인사항
`_installer/vars.yml`의 각 수동 버전 명시 패키지들의 버전이 원하는 대로인지 확인 하고 수정 후 설치시작

## execute with wget
```
bash -c "$(wget -qO - https://raw.githubusercontent.com/kwon37xi/dotfiles/main/install_start.sh)"
```

* sudo 용 패스워드를 한 번 입력해주고 진행

## _installer
* 설치에 필요한 ansible playbook 들이 있다.

## _backup
* 복사 방식으로 처리할 설정파일들이 들어있다.

## 나머지 디렉토리들
* gnu `stow` 명령으로 링크할 dotfiles 설정파일들이 있다.

## 설치 후 할 일들
* 후속 private dotfiles 설치

## additional drivers n
```
sudo software-properties-kde
```

### xanmod microcode 설치
* https://xanmod.org
* intel/amd 여부에 따라 서로 다르게 설치
```
# intel
sudo apt install intel-microcode iucode-tool

# amd
sudo apt install amd64-microcode
```

### KDE/QT/GTK 테마 설치 - Materia 기준
* **Materia** 와 **Arc**, **Papirus Icon** 테마들을 기본 설치 해둔 상태임
* KDE/QT, Gnome/GTK 모두 Materia와 Arc 를 지원하기 때문에 통일성 있는 구성 가능.
* 시스템 설정 열고
* 전역 테마 : Materia
* Plasma 스타일 : Materia
* 프로그램 모양
* 프로그램 스타일 : kvantum
  * Kvantum Manager 실행하고 **테마 변경 삭제**에서 MateriaDark 선택
* GTK2 테마 : Materia-dark
* GTK3 테마 : Materia-dark
* 창 장식 : Materia Dark
* 색상 : Materia Dark
* 아이콘 : Papirus-Dark
* 커서 : DMZ (검정색) (이게 어두운 화면에서 눈에 더 잘 띔)

### Panel 설정 변경
* Panel 작업 관리자에서 우클릭 "대체 항목 보기" -> **아이콘만 있는 작업 관리자** 로 전환
* 날짜 포맷 변경
  * 디지털 시계 위젯에서 "디지털 시계 설정" 클릭
  * 날짜표시(show date) 활성화
  * 시간대 코드 활성화
  * 시간표시 : 24시간제
  * 날짜 형식 : 사용자 정의 `dd dddd`
* Panel 편집
  * **시스템 트레이** 설정의 "항목"에서
  * **클립 보드** : 비활성화됨 (copyq 로 대체)
  * **터치패드** : 항상표시

### 작업공간 행동 변경
* 가상 바탕 화면 : 세로로 4개
  * **4열**로 만들고
  * 각 열마나 하나씩의 바탕화면 추가
* 테스크톱 효과
  * 각종 효과 켜주기

### 디스플레이와 모니터
* 컴포지터
  * 시작할 때 커포지팅 사용하기 : 활성화
  * 렌더링 백엔드 : OpenGL 2.0 혹은 3.1. 보통은 2.0이 안정적인듯.

### 입력장치
* 터치패드
  * 탭으로 클릭 : 활성화
  * 스크롤
    * 두 손가락 : 활성화
    * 스크롤 방향 반전(자연스크롤)

### fcitx
* fcitx 사용시, 설치 완료후, keyboard 에 **hangul** 을 추가해줘야만한다.
* 또한 KDE Panel 에 Input Method Widget을 추가해주면 좋다(kimpanel).

### Browser Plasma Integration 설치
* Plasma Integration 을 설치하면, Browser Tab 검색, 다운로드 알림 등이 통합된다.
* [Firefox Plasma Integration](https://addons.mozilla.org/en-US/firefox/addon/plasma-integration/)
* [Chrome Plasma Integration](https://chrome.google.com/webstore/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai)

### 단축키 보정
* 시스템 설정 열고 각종 단축키 설정 올바로 안 된 것들 보정

### 개발 관련
* IntelliJ Idea 설치
```
~/.local/opt/JetBrains/ideaIU/bin/idea.sh
```
### Libreoffice
* 도구 -> 기본설정 -> 보기 -> 아이콘 스타일 : dark 계통으로 변경한것. 그렇지 않으면 아이콘이 잘 안보인다.

### 4k 설정
* 4k 모니터 Console 및 Grub 설정등
```
ansible-playbook -vv ~/.dotfiles/_installer/4k_playbook.yml
```
* SDDM 의 경우 4K 설정이 자동 적용이 안되므로 **System Settings -> Startup and Shutdown -> Login Screen(SDDM) -> Advanced** 에서 **Sync**를 해줘야만 한다.
* 마우스 우클릭으로 나오는 컨텍스트 메뉴의 icon 이 너무 작을 경우
  * **System Settings -> Icons -> Configure Icon Sizes -> Small Icons** 값을 **32** 정도로 변경하고 Apply, logout/login 한다.
