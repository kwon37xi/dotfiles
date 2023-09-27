#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/${USER}/.sdkman"
[[ -s "/home/${USER}/.sdkman/bin/sdkman-init.sh" ]] && source "/home/${USER}/.sdkman/bin/sdkman-init.sh"

# SDKMAN + fzf functions
# https://www.grailbox.com/2021/04/switch-among-java-versions-fzf-and-sdkman/
# 현재 shell 용 java version 지정
ju() {
    local javaversion="$(\ls ~/.sdkman/candidates/java | grep -v current | fzf --prompt '사용할 Java 버전 > ')"
    if [ -z "$javaversion" ]
    then
        echo "Java 버전을 지정하지 않았습니다."
    else
        echo "Java ${javaversion}을 사용합니다."
        sdk use java "${javaversion}"
    fi
}

# default java 버전 지정
jd() {
    local javaversion="$(\ls ~/.sdkman/candidates/java | grep -v current |  fzf --prompt '기본으로 지정할 Java 버전 > ')"
    if [ -z "$javaversion" ]
    then
        echo "Java 버전을 지정하지 않았습니다."
    else
        echo "Java ${javaversion}을 기본값으로 지정합니다."
        sdk default java "${javaversion}"
    fi
}

# install jdk
ji() {
    local javaversion="$(sdk list java | grep -E '(.+\|){5}' | grep -v '^\sVendor' | grep -v 'installed\|local only' | awk '{print $NF}' | fzf --prompt '설치할 Java 버전 > ')"
    if [ -z "$javaversion" ]
    then
        echo "Java 버전을 지정하지 않았습니다."
    else
        echo "Java ${javaversion}을 설치합니다."
        sdk install java "${javaversion}"
    fi
}

# remoev jdk
jr() {
    local javaversion="$(\ls ~/.sdkman/candidates/java | grep -v current | fzf --prompt '삭제할 Java 버전 > ')"
    if [ -z "$javaversion" ]
    then
        echo "Java 버전을 지정하지 않았습니다."
    else
        echo "Java ${javaversion}을 삭제합니다."
        sdk uninstall java "${javaversion}"
    fi
}

# installed JDK list
_sdkman_ji() {
    \ls ~/.sdkman/candidates/java | grep -v current |
        fzf --prompt "설치된 Java 버전목록 > "
}

# JDK list except installed
_sdkman_jl() {
    sdk list java | grep -E '(.+\|){5}' | grep -v '^\sVendor' | grep -v 'installed\|local only' | awk '{print $NF}' |
        fzf --prompt "설치하지 않은 Java 버전목록 > "
}

_sdkman_jall() {
    sdk list java | grep -E '(.+\|){5}' | grep -v '^\sVendor' | awk '{ if ($(NF-2) == "only" || $(NF-2) == "installed") print "* " $NF; else print "- " $NF } ' |
        fzf --prompt "모든 Java 버전목록 (*: installed, -: not installed) > " | awk '{ print $NF }'
}

_sdkman_menu() {
    local menu=$(echo -e "all Java Versions\nlocal Java Versions\nremote Java Versions" | fzf)
    case $menu in
        "local Java Versions") _sdkman_ji;;
        "remote Java Versions") _sdkman_jl;;
        *) _sdkman_jall;;
    esac
}

# $- =~ i : interactive shell 일 경우
if [[ $- =~ i ]]; then
  # tmux 가 아닌경우 redraw-current-line 이 필요할 수있음.
  bind '"\er": redraw-current-line'
  # shell-expand-line 은 bind-x*.bashrc에서 \e\C-l 로 지정했음.
  bind '"\C-j\C-a": "$(_sdkman_jall)\e\C-l\er"'
  bind '"\C-j\C-i": "$(_sdkman_ji)\e\C-l\er"'
  bind '"\C-j\C-l": "$(_sdkman_jl)\e\C-l\er"'
  bind '"\C-j\C-j": "$(_sdkman_menu)\e\C-l\er"'
fi
