#!/bin/bash
export CDIR=`dirname $0`
chmod u+x $CDIR/adb
${CDIR}/adb disconnect
${CDIR}/adb connect 30.11.32.21
sleep 2
export Url="http://www.baidu.com"
export Width=1920
export Height=1080
export Position=0
export FullScreen=0
export ShowSeconds=56
${CDIR}/adb shell am broadcast -a com.yunos.tv.advertise.pushcenter.lego.LegoCommandAction -e LegoCommand BizCommand -e BizName BKBG -e BizId 0 -e Position $Position -e Width $Width -e Height $Height -e Url $Url -e FullScreen $FullScreen -e ShowSeconds $ShowSeconds -e UrlDecode false
${CDIR}/adb disconnect
echo 按任意键继续

