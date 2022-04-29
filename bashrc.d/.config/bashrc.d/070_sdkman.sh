#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/${USER}/.sdkman"
[[ -s "/home/${USER}/.sdkman/bin/sdkman-init.sh" ]] && source "/home/${USER}/.sdkman/bin/sdkman-init.sh"

# SDKMAN + fzf functions
# https://www.grailbox.com/2021/04/switch-among-java-versions-fzf-and-sdkman/
# 현재 shell 용 java version 지정
ju() {
   sdk use java "$(sdk list java | grep 'installed\|local only' | grep -v '>>>' | awk '{print $NF}' | fzf)"
}

# default java 버전 지정
jd() {
   sdk default java "$(sdk list java | grep 'installed\|local only' | awk '{print $NF}' | fzf)"
}

# install jdk
ji() {
   sdk install java "$(sdk list java | tail -n +6 | head -n -5 | grep -v 'installed\|local only' | awk '{print $NF}' | fzf)"
}
