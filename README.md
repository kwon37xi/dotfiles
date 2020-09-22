# dotfiles
My Linux dotfiles and installation scripts

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
* IntelliJ Idea 설치 : `~/.local/opt/JetBrains/ideaIU/bin/idea.sh`
