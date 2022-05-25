# 운세 혹은 격언

# 명시적으로 RANDOM_TLDR=0 이면 출력 안함
random_tldr="${RANDOM_TLDR:-1}"

# jetbrains intellij 계열 터미널에서 출력 안함.
if [ "$TERMINAL_EMULATOR" = "JetBrains-JediTerm" ]
then
    random_tldr=0
fi

# vscode 터미널에서도 출력 안함.
if [ "$TERM_PROGRAM" = "vscode" ]
then
    random_tldr=0
fi

if [ $random_tldr -eq 1 ]
then
    ~/.local/bin/tldr --random | cowsay -W 80 -f $(\ls /usr/share/cowsay/cows/*.cow | sort -R | head -n 1 | xargs basename -s .cow) | lolcat
fi
