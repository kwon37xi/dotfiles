# dotfiles
My Linux dotfiles and installation scripts

## PPA 주의점
* PPA의 경우 Ubuntu 의 6개월 버전업을 올바로 따라가지 못하는 경우가 많이 발생한다.
* Ubuntu 를 6개월마다 버전업할 예정이고, 해당 패키지가 Ubuntu 에 비록 버전이 뒤지더라도 항상 있는것이라면 가급적 Ubuntu 기본을 사용하는게 낫다.
* 그렇지 않으면, Ubuntu 가 버전업 돼도 PPA가 해당 버전의 신규 패키지를 못 좇아와서 올바로 신규 버전 설치가 안될 수 있다.

## 설치 전 확인사항
* `_installer/vars.yml`의 각 수동 버전 명시 패키지들의 버전이 원하는 대로인지 확인 하고 수정 후 설치시작
* Ubuntu Mirror 를 한국으로 변경한 뒤에 설치를 시작한다. : `http://mirror.kakao.com/ubuntu`
  * Pop! OS 는 **Pop Shop -> Settings -> Official Sources**에 추가해준다.
  * `sudo apt update` 한 번 해준다.

## execute with wget
```
bash -c "$(wget -qO - https://raw.githubusercontent.com/kwon37xi/dotfiles/ubuntu-gnome-20-10/install_start.sh)"
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

## additional drivers
```
sudo software-properties-gtk
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

### Pop Gnome 설정
* **설정 -> 지역 및 언어 -> Manage Installed Languages**에서 부족한 패키지 자동 설치
* uim/fcitx 사용시에는  **설정 -> Keyboard**에서 **hangul** 제거
* `/usr/share/themes/<원하는테마-보통 Pop-dark>/gnome-shell/gnome-shell.css` 파일에서 `.panel-button`의 `hpadding`항목 값들을
  **1px**로 변경해주면 Panel 의 인디케이터 부분의 아이콘간 간격이 줄어들게 된다.
  * `dash-to-panel` 사용시에는 해당 설정의 **Fine Tune** 에서 설정값으로 조정가능하다.

### Super 키 오작동 & 노트북 오른쪽 Alt/Ctrl 한영,한자키
* `gnome-tweaks` -> 키보드와 마우스 -> 추가배치 옵션
  * Alt/Win 키 동작
    * Hyper를 윈도우 키로 매핑
  * 한국어 한/영, 한자키
    * 오른쪽 Alt를 한/영 키로 만들기
    * 오른쪽 Ctrl을 한/영 키로 만들기

### 입력장치
* 터치패드
  * 탭으로 클릭 : 활성화
  * 스크롤
    * 두 손가락 : 활성화
    * 스크롤 방향 반전(자연스크롤)

### fcitx
* fcitx 사용시, 설치 완료후, keyboard 에 **hangul** 을 추가해줘야만한다.
* 또한 KDE Panel 에 Input Method Widget을 추가해주면 좋다(kimpanel).

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
