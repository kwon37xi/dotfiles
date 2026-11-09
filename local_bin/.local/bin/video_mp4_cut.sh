#!/bin/bash

# 사용법 안내 함수
usage() {
    echo "사용법: $0 [원본영상.mp4] [시작시점_ms] [재생시간_ms] [출력영상.mp4]"
    echo "예시:   $0 input.mp4 3500 2250 output.mp4"
    exit 1
}

# 입력 매개변수 개수 확인 (4개 필수)
if [ "$#" -ne 4 ]; then
    usage
fi

INPUT_FILE="$1"
START_MS="$2"
DURATION_MS="$3"
OUTPUT_FILE="$4"

# 파일 존재 여부 확인
if [ ! -f "$INPUT_FILE" ]; then
    echo "오류: 원본 영상 파일($INPUT_FILE)이 존재하지 않습니다."
    exit 1
fi

# 정수 여부 확인 (ms 값이 숫자인지 체크)
if ! [[ "$START_MS" =~ ^[0-9]+$ ]] || ! [[ "$DURATION_MS" =~ ^[0-9]+$ ]]; then
    echo "오류: 시작 시점과 재생 시간은 밀리초(정수) 단위로 입력해야 합니다."
    exit 1
fi

# 밀리초(ms)를 ffmpeg가 인식하는 초(seconds) 단위로 변환 (bc 활용)
# 예: 3500 -> 3.500 / 2250 -> 2.250
START_SEC=$(echo "scale=3; $START_MS / 1000" | bc)
DURATION_SEC=$(echo "scale=3; $DURATION_MS / 1000" | bc)

echo "----------------------------------------"
echo "영상 커팅을 시작합니다."
echo "원 본: $INPUT_FILE"
echo "시 작: $START_MS ms (${START_SEC}초)"
echo "기 간: $DURATION_MS ms (${DURATION_SEC}초)"
echo "출 력: $OUTPUT_FILE"
echo "----------------------------------------"

# ffmpeg 명령어 실행 (정확한 ms 싱크를 위해 재인코딩 적용)
ffmpeg -ss "$START_SEC" -i "$INPUT_FILE" -t "$DURATION_SEC" -y "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "🎉 영상 커팅이 성공적으로 완료되었습니다: $OUTPUT_FILE"
else
    echo "❌ 작업 중 오류가 발생했습니다."
fi

