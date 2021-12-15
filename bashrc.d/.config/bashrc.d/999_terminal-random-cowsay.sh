# 운세 혹은 격언

# 명시적으로 RANDOM_TLDR=0 이면 출력 안함
random_tldr="${RANDOM_TLDR:-1}"

# vscode 터미널에서도 출력 안함.
if [ "$TERM_PROGRAM" = "vscode" ]
then
    random_tldr=0
fi
if [ $random_tldr -eq 1 ]
then
    \tldr --random | cowsay -W 100 -f tux | lolcat
fi
