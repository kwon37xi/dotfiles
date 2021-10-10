OLDPATH=$PATH
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# https://unix.stackexchange.com/questions/537062/homebrew-replaced-python3-how-to-reverse
# homebrew 가 PATH 를 시스템보다 우선 설정하여 system python, gcc 등 사용에 문제가 발생함. 시스템을 우선하게 변경
export PATH=$OLDPATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin
