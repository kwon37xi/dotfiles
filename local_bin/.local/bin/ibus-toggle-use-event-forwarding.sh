#!/bin/sh
# ibus use-event-forward 기능을 꺼야 zoom 등 옛날 QT 라이브러시 사용하는 애플리케이션이 정상작동하고,
# 반대로 켜야만 intellij 등을 비롯한 일부 애플리케이션이 정상작동한다. 이를 토글해주는 shell script

if $(gsettings get org.freedesktop.ibus.engine.hangul use-event-forwarding); then
    gsettings set org.freedesktop.ibus.engine.hangul use-event-forwarding false
    notify-send -t 2000 "use-event-forwarding : false - Zoom QT 용"
else
    gsettings set org.freedesktop.ibus.engine.hangul use-event-forwarding true
    notify-send -t 2000 "use-event-forwarding : false - 일반 애플리케이션용"
fi

