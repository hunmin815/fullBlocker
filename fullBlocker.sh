#!/bin/bash

# 변수 설명
# Block_PER : 제한 사용량(%)
# logDir    : 솔루션 로그 경로
# ck_Part   : 체크 파티션 이름
# Solu      : 솔루션 번호

source ~/.bash_profile || source ~/.profile # OS 별 환경 변수 호출 (RedHat, Debian)
export LANG=c

logFile=$fullBlocker_Dir./fullBlocker.log # fullBlocker 로그 파일 설정

cd $logDir

Use=$(df -Th | grep -w $ck_Part | awk {'print $6'} | awk -F"%" {'print $1'}) # 사용량 조회

# 각 솔루션 별 삭제 구문 생성
case $Solu in
1) # DB*AFE*
  DEL=$(ls -al | grep -v "total" | grep $logName[0-9][0-9] | head -n1 | awk {'print $9'})
  ;;
2) # Sec*e*ua*d
  year_Dir=$(ls -al | grep -v "total" | grep -w [0-9][0-9][0-9][0-9]$ | head -n1 | awk {'print $9'})
  cd $year_Dir
  DEL=$(ls -al | grep -v "total" | grep -w [0-9][0-9]$ | head -n1 | awk {'print $9'})
  ;;
esac

# 로그 삭제 여부 결정
if [ $Use -ge $Block_PER ]; then
  echo ""
  echo "=== $(date) [warn] '$ck_Part' Partition $Block_PER% Over ===" && echo "=== $(date) [warn] '$ck_Part' Partition $Block_PER% Over ===" >>$logFile 2>&1 # 현재 파티션 사용량 이상 경고 문구

  echo $(du -sh ./$DEL) && du -sh ./$DEL >>$logFile 2>&1 # 솔루션 로그 용량 측정

  echo "$DEL Deleting ..." && echo "$DEL Deleting ..." >>$logFile 2>&1

  rm -rf ./$DEL >>$logFile 2>&1 # 솔루션 로그 삭제
  echo "Delete Ok" && echo "Delete Ok" >>$logFile 2>&1

  echo "===================================================================" >>$logFile 2>&1
  echo ""
else
  echo "$(date) [info] '$ck_Part' Partition >> Use: $Use%" && echo "$(date) [info] '$ck_Part' Partition >> Use: $Use%" >>$logFile 2>&1 # 현재 파티션 사용량 정보
fi
