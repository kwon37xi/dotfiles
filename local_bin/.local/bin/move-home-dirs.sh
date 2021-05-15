#!/bin/bash
# $HOME 의 기본 디렉토리들(Downloads, Documents,Music,Pictures,Public,Templates,Videos)을 다른 파티션으로 옮긴다.
# 다른 파티션에 현재 사용자의 권한이 존재해야 한다.
# move-home-dirs.sh /target/home

target_dir="$1"
if [ "$target_dir" == "" ]
then
    echo "대상 디렉토리를 지정해주세요."
    exit 1
fi

if ! [ -d $target_dir ]
then
    echo "$target_dir 은 디렉토리가 아닙니다."
    exit 1
fi

for home_dir in Downloads Documents Music Pictures Public Templates Videos
do
    echo "# 홈 디렉토리 이동 시작 - $HOME/$homedir -> $target_dir/$home_dir"

    if ! [ -d $target_dir/$home_dir ]
    then
        echo "   디렉토리 생성 - $target_dir/$home_dir ..."
        sudo mkdir $target_dir/$home_dir
        sudo chown $USER:$USER $target_dir/$home_dir
    fi

    mv $HOME/$home_dir/* $target_dir/$home_dir
    echo "$HOME/$home_dir -> $target_dir/$home_dir 이동 완료"
    rmdir $HOME/$home_dir
    ln -s $target_dir/$home_dir $HOME
done
