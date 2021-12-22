#!/bin/bash

echo "" >>~/.bash_profile || echo "" >>~/.profile
echo "######### fullBlocker #########" >>~/.bash_profile || echo "######### fullBlocker #########" >>~/.profile

# Set Solution
echo "== start fullBlocker config Set ==" && echo "" && echo ""
echo "== 1- DB*AFE* / 2- Sec*e*ua*d =="
printf "Select NUM (ex. 1): "
read Solu

echo "export Solu=$Solu" >>~/.bash_profile || echo "export Solu=$Solu" >>~/.profile

case $Solu in
1) # DB*AFE*
  echo "export logName=dbsafer_log_" >>~/.bash_profile || echo "export logName=dbsafer_log_" >>~/.profile
  ;;
2) # Sec*e*ua*d
  echo ""
  ;;
esac

# Set Partition
echo ""
echo "== Check Partition Setting =="
printf "Name (ex. /home): "
read ck_Part

echo "export ck_Part=$ck_Part" >>~/.bash_profile || echo "export ck_Part=$ck_Part" >>~/.profile

# Set log Directory
ck=0
while [ $ck -eq 0 ]; do
  echo ""
  echo "== log Directory Setting =="
  printf "Dir (ex. /home/log/): "
  read logDir

  if [ ! -z $(echo $logDir | grep /$) ]; then
    echo "export logDir=$logDir" >>~/.bash_profile || echo "export logDir=$logDir" >>~/.profile
    ck=1
  else
    echo "Wrong Value : ex)Essential last String '/' Please Retry"
  fi
done

# Set fullBlocker Directory
ck=0
while [ $ck -eq 0 ]; do
  echo ""
  echo "== Set fullBlocker Directory =="
  printf "Dir (ex. /work/fullBlocker/): "
  read fullBlocker_Dir

  if [ ! -z $(echo $fullBlocker_Dir | grep /$) ]; then
    echo "export fullBlocker_Dir=$fullBlocker_Dir" >>~/.bash_profile || echo "export fullBlocker_Dir=$fullBlocker_Dir" >>~/.profile
    ck=1
  else
    echo "Wrong Value : ex)Essential last String '/' Please Retry"
  fi
done

# Set limit Percent (%)
echo ""
echo "== Set limit Percent (%) =="
printf "Block_PER (ex. 90): "
read Block_PER

echo "export Block_PER=$Block_PER" >>~/.bash_profile || echo "export Block_PER=$Block_PER" >>~/.profile

echo ""
echo "== Setting Crontab (/etc/crontab)..."
echo "== set time : 30 00 * * * root"
echo "" >>/etc/crontab
echo "############## fullBlocker ##############" >>/etc/crontab
echo "30 00 * * * root $fullBlocker_Dir./fullBlocker.sh" >>/etc/crontab
echo "############## fullBlocker ##############" >>/etc/crontab
echo "== Restarting Crontab Service..."
systemctl restart crond || systemctl restart cron || service crond restart || service cron restart

echo ""
echo "== OK Setting Complete!"
echo "######### fullBlocker #########" >>~/.bash_profile || echo "######### fullBlocker #########" >>~/.profile
