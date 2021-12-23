#!/bin/bash

### Set Solution ###
echo "== start fullBlocker config Set ==" && echo "" && echo ""
echo "== 1- DB*AFE* / 2- Sec*e*ua*d =="
printf "Select NUM (ex. 1): "
read Solu

### Set Partition ###
echo ""
echo "== Check Partition Setting =="
printf "Name (ex. /home): "
read ck_Part

### Set log Directory ###
ck=0 # while 탈출 조건
while [ $ck -eq 0 ]; do
  echo ""
  echo "== log Directory Setting =="
  printf "Dir (ex. /home/log/): "
  read logDir

  if [ ! -z $(echo $logDir | grep /$) ]; then
    ck=1 # while exit
  else
    echo "Wrong Value : ex)Essential last String '/' Please Retry"
  fi
done

### Set fullBlocker Directory ###
ck=0
while [ $ck -eq 0 ]; do
  echo ""
  echo "== Set fullBlocker Directory =="
  printf "Dir (ex. /work/fullBlocker/): "
  read fullBlocker_Dir

  if [ ! -z $(echo $fullBlocker_Dir | grep /$) ]; then
    ck=1
  else
    echo "Wrong Value : ex)Essential last String '/' Please Retry"
  fi
done

### Set limit Percent (%) ###
echo ""
echo "== Set limit Percent (%) =="
printf "Block_PER (ex. 90): "
read Block_PER

### Set Crontab ###
echo ""
echo "== Setting Crontab (/etc/crontab)..."
echo "== set time : 30 00 * * * root"
echo "" >>/etc/crontab
echo "############## fullBlocker ##############" >>/etc/crontab
echo "30 00 * * * root $fullBlocker_Dir./fullBlocker.sh" >>/etc/crontab # 00:30 실행
echo "############## fullBlocker ##############" >>/etc/crontab
echo "== Restarting Crontab Service..."
systemctl restart crond || systemctl restart cron || service crond restart || service cron restart

### 작성 완료 후 실제 값 Insert ###
echo "" >>~/.bash_profile || echo "" >>~/.profile
echo "######### fullBlocker #########" >>~/.bash_profile || echo "######### fullBlocker #########" >>~/.profile

echo "export Solu=$Solu" >>~/.bash_profile || echo "export Solu=$Solu" >>~/.profile # 솔루션 종류

# 로그 이름 설정
case $Solu in
1) # DB*AFE*
  echo "export logName=dbsafer_log_" >>~/.bash_profile || echo "export logName=dbsafer_log_" >>~/.profile
  ;;
2) # Sec*e*ua*d
  echo ""
  ;;
esac

echo "export ck_Part=$ck_Part" >>~/.bash_profile || echo "export ck_Part=$ck_Part" >>~/.profile                                 # 파티션 명
echo "export logDir=$logDir" >>~/.bash_profile || echo "export logDir=$logDir" >>~/.profile                                     # 로그 경로
echo "export fullBlocker_Dir=$fullBlocker_Dir" >>~/.bash_profile || echo "export fullBlocker_Dir=$fullBlocker_Dir" >>~/.profile # fullBlocker 경로
echo "export Block_PER=$Block_PER" >>~/.bash_profile || echo "export Block_PER=$Block_PER" >>~/.bash_profile                    # 사용량 임계치
echo "######### fullBlocker #########" >>~/.bash_profile || echo "######### fullBlocker #########" >>~/.profile

echo ""
echo "== OK Setting Complete!"
