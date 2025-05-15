#/usr/bin/env bash
# https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release 는 
# jetbrains-toolbox의 최신 버전 정보를 제공하는 API입니다.
# 이 API를 사용하여 최신 버전의 JetBrains Toolbox를 다운로드할 수 있습니다.
# 이 스크립트는 JetBrains Toolbox의 최신 버전을 다운로드하고 설치합니다.
# 설치 경로는 ~/.local/share/JetBrains/Toolbox입니다.

# JetBrains Toolbox의 최신 버전 다운로드 및 설치
set -e

TOOLBOX_DIR="$HOME/.local/share/JetBrains/Toolbox"

# TOOLBOX_DIR이 존재하면 삭제
if [ -d "$TOOLBOX_DIR" ]; then
    echo "Removing existing JetBrains Toolbox directory..."
    rm -rf "$TOOLBOX_DIR"
fi

mkdir -p "$TOOLBOX_DIR"
cd "$TOOLBOX_DIR"

# bin 디렉토리에 설치
mkdir bin
cd bin

# Get the latest version of JetBrains Toolbox - linux X86_64(AMD64) 버전임
RELEASES_API_URL="https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
LATEST_URL=$(curl -s "$RELEASES_API_URL" | jq -r '.TBA[0].downloads.linux.link')

# Download the latest version
if [ -z "$LATEST_URL" ]; then
    echo "Failed to get the latest version URL."
    exit 1
fi

wget -q --show-progress "$LATEST_URL" -O jetbrains-toolbox.tar.gz

# Extract the downloaded file
tar -xzf jetbrains-toolbox.tar.gz --strip-components=1

# Remove the downloaded tar.gz file
rm jetbrains-toolbox.tar.gz

# Make the binary executable
chmod +x jetbrains-toolbox

echo "JetBrains Toolbox has been installed to $TOOLBOX_DIR"

# execute the JetBrains Toolbox
"$TOOLBOX_DIR/bin/jetbrains-toolbox" &