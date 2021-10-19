# dotfiles
My Linux dotfiles and installation scripts

## PPA 주의점
* PPA의 경우 Ubuntu 의 6개월 버전업을 올바로 따라가지 못하는 경우가 많이 발생한다.
* Ubuntu 를 6개월마다 버전업할 예정이고, 해당 패키지가 Ubuntu 에 비록 버전이 뒤지더라도 항상 있는것이라면 가급적 Ubuntu 기본을 사용하는게 낫다.
* 그렇지 않으면, Ubuntu 가 버전업 돼도 PPA가 해당 버전의 신규 패키지를 못 좇아와서 올바로 신규 버전 설치가 안될 수 있다.

## 설치 전 확인사항
* `_installer/vars.yml`의 각 수동 버전 명시 패키지들의 버전이 원하는 대로인지 확인 하고 수정 후 설치시작
* `software-properties-gtk` 를 실행하고,
  * 미러를 `http://mirror.kakao.com/ubuntu` 정도의 한국 미러로 변경한다.

## execute with wget
```
bash -c "$(wget -qO - https://raw.githubusercontent.com/kwon37xi/dotfiles/main/install_start.sh)"
```

* sudo 용 패스워드를 한 번 입력해주고 진행

## 가상머신에서 테스트 할경우
* VirtualBox Guest Addition 을 미리 설치
* 간혹 VirtualBox + wayland 에서 사용시 설치 과정에서 wayland가 다운됨. X org 로 전환해서 테스트 할 것.
* `설정 -> 전원`에서 빈화면 절전 안하게 변경
* 웹 브라우저등에 https://github.com/kwon37xi/dotfiles 미리 북마크
* Terminal 바로가기 설정
* `sudo apt update; sudo apt upgrade`
* 이 상태로 종료하고 Snapshot 을 저장해둔다.

## _installer
* 설치에 필요한 ansible playbook 들이 있다.
* ansible log 는 `/var/log/ansible-dotfiles.log` 로 남는다.

## _backup
* 복사 방식으로 처리할 설정파일들이 들어있다.

## 나머지 디렉토리들
* gnu `stow` 명령으로 링크할 dotfiles 설정파일들이 있다.

## 설치 후 할 일들
* `install_extra_packages.sh` 를 실행하여 부가 패키지들(당장 개발에 필요는 없지만 일상생활에 필요한)을 설치한다.
* 후속 private dotfiles 설치

### HOME 기본 디렉토리 다른 파티션으로 이동
* 별도 디스크 혹은 파티션으로 홈에 있는 각 기본 디렉토리(Downloads,Documents,...)를 옮기고 싶다면,
`$HOME/.local/bin/move-home-dirs.sh <대상Directory>` 를 실행한다.

```
~/.local/bin/move-home-dirs.sh /mnt/data
```

### additional drivers
```
sudo software-properties-gtk
```

### microcode 설치
* intel/amd 여부에 따라 서로 다르게 설치
```
# intel
sudo apt install intel-microcode iucode-tool

# amd
sudo apt install amd64-microcode
```

### Gnome 설정
* **설정 -> 지역 및 언어 -> Manage Installed Languages**에서 부족한 패키지 자동 설치
* ibus 사용시에는 **설정 -> 지역 및 언어**에서 **한국어 (Hangul)**만 남기고 지운다.
* uim/fcitx 사용시에는  **설정 -> Keyboard**에서 **hangul** 제거
* Top Bar 사용시 : `/usr/share/themes/<원하는테마>/gnome-shell/gnome-shell.css` 파일에서 `.panel-button`의 `hpadding`항목 값들을
  **1px**로 변경해주면 Panel 의 인디케이터 부분의 아이콘간 간격이 줄어들게 된다.
* `dash-to-panel` 사용시에는 해당 설정의 **Fine Tune** 에서 설정값으로 padding 조정가능하다.

### Super 키 오작동 & 노트북 오른쪽 Alt/Ctrl 한영,한자키
* `gnome-tweaks` -> 키보드와 마우스
  * 바로가기 키 개요 : **오른쪽 Super 키** 로 변경한다. 이걸하면 왼쪽 Super 키가 올바르게 작동하고, 오른쪽 Super 키로 바로가기 개요를 볼 수 있다.
    * Ubuntu 21.04 부터는 왼쪽 Super  키로 두어도 ''Super+다른키조합''이 잘 작동하고 있다.
  * 추가배치 옵션
    * Alt/Win 키 동작 : 하지 말것. 더이상 불필요함.
      * -Hyper를 윈도우 키로 매핑-
    * 한국어 한/영, 한자키
      * 오른쪽 Alt를 한/영 키로 만들기
      * 오른쪽 Ctrl을 한자 키로 만들기

### 입력장치
* 터치패드 : dconf 설정에서 자동으로 하고 있음.
  * 탭으로 클릭 : 활성화
  * 스크롤
    * 두 손가락 : 활성화
    * 스크롤 방향 반전(자연스크롤)

### fcitx
* fcitx 사용시, 설치 완료후, keyboard 에 **hangul** 을 추가해줘야만한다.
* 또한 KDE Panel 에 Input Method Widget을 추가해주면 좋다(kimpanel).

### 단축키 보정
* 시스템 설정 열고 각종 단축키 설정 올바로 안 된 것들 보정 : dconf 설정에서 자동으로 하고 있음.

### 개발 관련
* IntelliJ Idea 설치
```
~/.local/opt/JetBrains/ideaIU/bin/idea.sh
```
* 설치 후 **Files -> Manage IDE Settings** 에서 온라인 동기화를 위해 로그인 할 것.

### Libre Office
* 도구 -> 기본설정 -> 보기 -> 아이콘 스타일 : dark 계통 테마일경우 아이콘 스타일을 dark 계통으로 변경한것. 그렇지 않으면 아이콘이 잘 안보인다.

### Grub Customizer
* Grub Theme 을 조정해준다.

### Conky
* `~/.conky` 에 conky 설정 파일들과 실행 스크립트가 있다.
* 시작 프로그램 설정을 통해 해당 스크립트를 실행하도록 한다.

### Jenkins 설치
* Jenkins 설치를 자동화 해 두었다.
```
ansible-playbook -vv ~/.dotfiles/_installer/jenkins_playbook.yml
```

### Vivaldi Browser Mod 설정
* Vivaldi Mod 설정으로 창 최대화/최소화 버튼 모양을 테마와 일치시킬 수 있다.
* vivaldi://experiments 열고
* "Allow for using CSS modifications" 활성화
* **설정 → 모양(Appearance)** **수정금지** 항목에서
* mod `*.css` 파일이 있는 디렉토리를 선택한다. `~/.dotfiles/_backup/vivaldi-themes/vivaldi-yaru-mod`
* Vivaldi 를 완전 종료하고 재시작한다.

### 4k 설정
* 4k 모니터 Console 설정
```
ansible-playbook -vv ~/.dotfiles/_installer/4k_playbook.yml
```

## JDK 디렉토리
* `.local/opt/jdk` 에 JDK 들을 설치하고 있다.

