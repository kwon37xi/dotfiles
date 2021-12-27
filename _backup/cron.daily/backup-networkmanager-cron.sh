#!/usr/bin/env bash
# NetworkManager의 설정 정보들을 local 로 백업한다.
# 이 백업된 정보들은 다시 pika/dejadup 등을 통해 원격지로 백업된다.
# 이 파일은 cron 에 의해 root 권한으로 실행된다.
# anacron 에 의해 하루에 PC가 켜진다면 최소 한번은 실행이 보장된다.
# local 에서 직접 실행은 ~/.local/bin/backup-networkmanager.sh 참조

# 아래 항목은 ansible에 의히 실제 사용자로 변경됨.

TARGET_USER=:CURRENT_USER:
logger "networkmanager connections backup started"
rm -rf "/home/$TARGET_USER/.local/backup/networkmanager"
mkdir -p "/home/$TARGET_USER/.local/backup/networkmanager/etc/NetworkManager"
cp -R /etc/NetworkManager/system-connections "/home/$TARGET_USER/.local/backup/networkmanager/etc/NetworkManager"
chown -R "$TARGET_USER:$TARGET_USER" "/home/$TARGET_USER/.local"

logger "networkmanager connections backuped successfully"
