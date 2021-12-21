#!/bin/bash

source ~/.bash_profile || source ~/.profile # OS 별 환경 변수 호출 (RedHat, Debian)

exeDir=$(dirname $0) # 스크립트 실행 경로
Block_PER=95         # 제한 사용량(%)
ck_Part="/home"      # 체크 파티션
logFile=~/fullBlocker/fullBlocker.log

cd $logDir

Use=$(df -Th | grep -w $ck_Part | awk {'print $6'} | awk -F"%" {'print $1'}) # 사용량 조회

if [ $Use -ge $Block_PER ]; then
  echo ""
  echo "=== $(date) [warn] '$ck_Part' Partition $Block_PER% Over ===" && echo "=== $(date) [warn] '$ck_Part' Partition $Block_PER% Over ===" >>$logFile 2>&1
  DEL=$(ll | grep $logName[0-9][0-9] | head -n1 | awk {'print $9'}) # 로그 파일 형식 ex) 이름숫자숫자
  echo $(du -sh ./$DEL) && du -sh ./$DEL >>$logFile 2>&1
  echo "$DEL Deleting ..." && echo "$DEL Deleting ..." >>$logFile 2>&1
  rm -rf ./$DEL >>$logFile 2>&1
  echo "Delete Ok" && echo "Delete Ok" >>$logFile 2>&1
  echo "===================================================================" >>$logFile 2>&1
  echo ""
else
  echo "$(date) [info] '$ck_Part' Partition >> Use: $Use%" && echo "$(date) [info] '$ck_Part' Partition >> Use: $Use%" >>$logFile 2>&1
fi
