#!/usr/bin/env bash
# ulauncher 에서 URL 노출없이 검색 shorcut을 만들기 위한 script
# 첫번째 파라미터로 환경변수 이름을 전달한다.
# 환경변수의 값은 곧바로 검색 키워드를 받을 수 있는 URL이어야 한다.

source ~/.config/bashrc.d/004_private_envs.sh

private_search_url="${!1}"
search_keyword="$2"

xdg-open "${private_search_url}${search_keyword}"
