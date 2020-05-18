#### 오른쪽 상단에 있는 Clone을 누른 후 Clone with HTTPS 링크를 복사해서 이클립스에서 임포트 합니다.

#### 로컬에서 개발시 DB는 오라클12c 버전입니다.

#### CREATE USER c##mm IDENTIFIED BY mm 명령어를 통해 오라클 계정을 추가하셔야 하며 grant connect, dba, resource to c##mm 명령어로 권한을 주어야 합니다.

#### 테이블 설계는 https://drive.google.com/drive/folders/1z3BTZf0AHC60WZG7QexAeVBVVjUt9S7l?ogsrc=32 에서 다운받으실 수 있습니다.

#### 테이블 설계를 보기 위해서는 테이블 설계 툴인 DA#을 설치 하셔야 합니다. (DA# 홈페이지 - http://dataware.kr/solution/new_idx)

<hr/>
★ 테이블 스크립트 생성 방법 ★

1. DA# 설치 후 팀드라이브에서 받은 테이블 설계 파일(.dax)을 엽니다.

2. 논리 구조로 되어 있는 것을 물리 구조로 바꿔 줍니다.

3. 데이터 - 스크립트 작성 Click!

4. 왼쪽 하단 객체 선택.. 을 누르고 바로 적용 버튼을 눌러줍니다.

5. 그 후 객체 선택.. 오른쪽에 있는 스크립트 생성을 눌러서 테이블 스크립트를 생성합니다.

6. 스크립트를 복사한 후 오라클 설치시 깔리는 SQL DEVELOPER에서 테이블을 생성해 줍니다.

※  테이블 모델링 툴에서 바로 연동도 가능합니다. 방법을  찾으신 후 공유 부탁드립니다.

<hr/>

### 이제 이클립스에서 자유롭게 NOS.MM을 개발을 하시기 바랍니다.


ps. 새로운 사항은 매번 README.md에 추가바랍니다.