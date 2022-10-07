#!/usr/bin/bash

extensions=(
    2gua.rainbow-brackets
    AdsonCicilioti.yaru-vscode
    DavidAnson.vscode-markdownlint
    EditorConfig.EditorConfig
    GabrielBB.vscode-lombok
    GitHub.github-vscode-theme
    GitHub.remotehub
    GitHub.vscode-pull-request-github
    MS-CEINTL.vscode-language-pack-ko
    PKief.material-icon-theme
    Perkovec.emoji
    Pivotal.vscode-boot-dev-pack
    Pivotal.vscode-spring-boot
    Remisa.shellman
    SonarSource.sonarlint-vscode
    Tyriar.sort-lines
    VisualStudioExptTeam.vscodeintellicode
    aaron-bond.better-comments
    adpyke.codesnap
    alefragnani.Bookmarks
    amazonwebservices.aws-toolkit-vscode
    atlassian.atlascode
    azemoh.one-monokai
    bajdzis.vscode-database
    christian-kohler.npm-intellisense
    christian-kohler.path-intellisense
    dbaeumer.vscode-eslint
    doggy8088.quicktype-refresh
    donjayamanne.githistory
    dsznajder.es7-react-js-snippets
    eamodio.gitlens
    ecmel.vscode-html-css
    eg2.vscode-npm-script
    esbenp.prettier-vscode
    evan-buss.font-switcher
    formulahendry.auto-rename-tag
    formulahendry.code-runner
    formulahendry.theme-ubuntu-style
    foxundermoon.shell-format
    fwcd.kotlin
    golang.go
    hashicorp.terraform
    humao.rest-client
    johnpapa.vscode-peacock
    jspolancor.presentationmode
    mads-hartmann.bash-ide-vscode
    mechatroner.rainbow-csv
    moyu.snapcode
    ms-azuretools.vscode-docker
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
    pflannery.vscode-versionlens
    pranaygp.vscode-css-peek
    redhat.ansible
    redhat.java
    redhat.vscode-yaml
    ritwickdey.LiveServer
    rogalmic.bash-debug
    ryanolsonx.solarized
    solnurkarim.html-to-css-autocompletion
    steoates.autoimport
    stevencl.addDocComments
    techer.open-in-browser
    timonwong.shellcheck
    usernamehw.errorlens
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
    george-alisson.html-preview-vscode
)

for extension in "${extensions[@]}"; do
    echo "extension : ${extension}"
    code --install-extension "${extension}"
done
