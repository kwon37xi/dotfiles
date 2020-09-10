#!/bin/sh
VBoxManage controlvm "71d11bbb-c0ec-4a22-93b2-06379b1201a7" resume
xfreerdp  /w:2540 /h:1440  /v:localhost:5940
VBoxManage controlvm "71d11bbb-c0ec-4a22-93b2-06379b1201a7" pause
