# fullBlocker
Linux system Disk Partition Full Prevention<br>
솔루션에 사용될 리눅스 디스크 full 방지 스크립트입니다.<br><br>

### config_set.sh
fullBlocker.sh 에서 필요한 환경변수 및 Crontab 세팅입니다.<br>

**Solu=** 솔루션 번호 선택<br>

**ck_Part=**  체크 할 파티션<br>

**logDir=** 솔루션 로그 디렉토리<br>

**fullBlocker_Dir=** fullBlocker 설치 경로<br>

**Block_PER=** 사용량 임계치<br>

**Crontab ->** 매일 00시 30분에 실행

#### 실행 화면
![image](https://user-images.githubusercontent.com/15862848/147172888-dcbd2f4c-9b17-49b7-8343-de48df7a109e.png)


<br><br>
### fullBlocker.sh
디스크 파티션의 사용량이 **설정한 값 이상**이 되면 **가장 오래된 로그 파일** 부터 삭제합니다.<br><br>
ex) **/home 파티션**의 임계치를 **6%로** 설정한 뒤 임의로 fullBlocker.sh 실행 한 결과입니다.<br><br>
- /home 파티션이 6% 이상이 되어 로그가 삭제된 모습<br>
![image](https://user-images.githubusercontent.com/15862848/147173736-035ce516-10f5-4c66-9119-956c3ae26157.png)<br><br>
- 디스크 상태 조회<br>
![image](https://user-images.githubusercontent.com/15862848/147173804-98e3af2b-edb7-49a7-ace4-17679983ec95.png)<br><br>

ex) **/home 파티션**의 임계치를 **7%로** 설정한 뒤 fullBlocker.sh 실행 한 결과입니다.<br><br>
- 현재 파티션 사용량 정보만 출력<br>
![image](https://user-images.githubusercontent.com/15862848/147174820-fefcab35-0b3c-483c-bad5-ecfbf927d160.png)<br>
- 디스크 상태 조회<br>
![image](https://user-images.githubusercontent.com/15862848/147174602-652c2840-e82c-4c96-9b1e-b26a8c0954b3.png)
