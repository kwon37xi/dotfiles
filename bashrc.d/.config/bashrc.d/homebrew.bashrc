OLDPATH=$PATH
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
# https://unix.stackexchange.com/questions/537062/homebrew-replaced-python3-how-to-reverse
# homebrew 가 PATH 를 시스템보다 우선 설정하여 system python, gcc 등 사용에 문제가 발생함. 시스템을 우선하게 변경
export PATH=$OLDPATH:${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin

# bash shell completion https://docs.brew.sh/Shell-Completion
# 이 항목은 PATH 설정 이후로 두어야 한다.
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    echo "for file"
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi
