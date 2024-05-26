#!/bin/bash
# https://www.nerdfonts.com/font-downloads

# install_nerd_fonts pckage_name url
function install_nerd_fonts {
    package_name="nerd-fonts-$1"
    url="$2"
    target_dir="$HOME/.fonts/${package_name}"
    download_file="${target_dir}/fonts.zip"
    keep_otf="${3:-false}"

    echo "=== Installing ${package_name}..."
    rm -rf $target_dir
    mkdir -p $target_dir
    wget -O ${download_file} $url

    unzip -e ${download_file} -d $target_dir

    rm -f "${target_dir}/"*Windows\ Compatible.*

    if [ "false" == "$keep_otf" ]; then
        echo "deleting otf files. - $keep_otf"
        rm -f "${target_dir}/"*.otf
    fi

    rm -f $download_file
}

install_nerd_fonts inconsolata "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Inconsolata.zip"
install_nerd_fonts isoveka "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip"
install_nerd_fonts caskaydia "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip"
install_nerd_fonts codenewroman "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CodeNewRoman.zip" true
install_nerd_fonts firacode "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
install_nerd_fonts hack "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"
install_nerd_fonts jetbrainsmono "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip"
install_nerd_fonts saucecodepro "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"
install_nerd_fonts terminus "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Terminus.zip"

fc-cache -vf
