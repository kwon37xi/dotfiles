#!/usr/bin/bash

extensions=(
    2gua.rainbow-brackets
    aaron-bond.better-comments
    AdsonCicilioti.yaru-vscode
    alefragnani.Bookmarks
    amazonwebservices.aws-toolkit-vscode
    atlassian.atlascode
    azemoh.one-monokai
    bajdzis.vscode-database
    christian-kohler.npm-intellisense
    DavidAnson.vscode-markdownlint
    dbaeumer.vscode-eslint
    doggy8088.quicktype-refresh
    donjayamanne.githistory
    dsznajder.es7-react-js-snippets
    eamodio.gitlens
    ecmel.vscode-html-css
    EditorConfig.EditorConfig
    eg2.vscode-npm-script
    esbenp.prettier-vscode
    formulahendry.auto-rename-tag
    formulahendry.code-runner
    formulahendry.theme-ubuntu-style
    foxundermoon.shell-format
    fwcd.kotlin
    GabrielBB.vscode-lombok
    GitHub.github-vscode-theme
    GitHub.remotehub
    GitHub.vscode-pull-request-github
    golang.go
    hashicorp.terraform
    HookyQR.beautify
    humao.rest-client
    mads-hartmann.bash-ide-vscode
    mechatroner.rainbow-csv
    moyu.snapcode
    ms-azuretools.vscode-docker
    MS-CEINTL.vscode-language-pack-ko
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-python.python
    ms-python.vscode-pylance
    ms-toolsai.jupyter
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-wsl
    ms-vscode-remote.vscode-remote-extensionpack
    ms-vscode.vscode-typescript-tslint-plugin
    ms-vsliveshare.vsliveshare
    mtxr.sqltools
    mwpb.java-prettier-formatter
    naco-siren.gradle-language
    oderwat.indent-rainbow
    p1c2u.docker-compose
    Perkovec.emoji
    Pivotal.vscode-boot-dev-pack
    Pivotal.vscode-spring-boot
    PKief.material-icon-theme
    pranaygp.vscode-css-peek
    redhat.ansible
    redhat.java
    redhat.vscode-yaml
    Remisa.shellman
    ritwickdey.LiveServer
    rogalmic.bash-debug
    ryanolsonx.solarized
    solnurkarim.html-to-css-autocompletion
    SonarSource.sonarlint-vscode
    steoates.autoimport
    stevencl.addDocComments
    tht13.html-preview-vscode
    timonwong.shellcheck
    Tyriar.sort-lines
    usernamehw.errorlens
    VisualStudioExptTeam.vscodeintellicode
    vscjava.vscode-gradle
    vscjava.vscode-java-debug
    vscjava.vscode-java-dependency
    vscjava.vscode-java-pack
    vscjava.vscode-java-test
    vscjava.vscode-maven
    vscjava.vscode-spring-boot-dashboard
    vscjava.vscode-spring-initializr
    wayou.vscode-todo-highlight
    wix.vscode-import-cost
    wmaurer.change-case
    wmaurer.vscode-jumpy
)

for extension in "${extensions[@]}"; do
    echo "extension : ${extension}"
    code --install-extension "${extension}"
done
