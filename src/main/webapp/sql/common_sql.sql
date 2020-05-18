 -- Sequence
CREATE SEQUENCE AUTH_SEQ
    START WITH 1
  INCREMENT BY 1;
  
CREATE SEQUENCE MEM_SEQ
    START WITH 1
  INCREMENT BY 1;
  
CREATE SEQUENCE GROUP_SEQ
    START WITH 1
  INCREMENT BY 1;
  
CREATE SEQUENCE MENU_SEQ 
    START WITH 1
  INCREMENT BY 1;
  
CREATE SEQUENCE CLIENT_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE WORK_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE REQ_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE WORK_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE MN_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE MANAGEMENT_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE SUP_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE UP_SEQ
START WITH 1
INCREMENT BY 1;
  
CREATE SEQUENCE WS_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE RM_SEQ
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE PJ_JOIN_SEQ
    START WITH 1
  INCREMENT BY 1;
  
  
  CREATE SEQUENCE PJ_SEQ
    START WITH 1
  INCREMENT BY 1;

-- Auth
INSERT INTO AUTH(
                  AUTH_NO
                , AUTH_NAME
                )
      VALUES(
              AUTH_SEQ.NEXTVAL
            , 'ROLE_ADMIN'
            );
INSERT INTO AUTH(
                  AUTH_NO
                , AUTH_NAME
                )
      VALUES(
              AUTH_SEQ.NEXTVAL
            , 'ROLE_MEMBER'
            );
INSERT INTO AUTH(
                  AUTH_NO
                , AUTH_NAME
                )
      VALUES(
              AUTH_SEQ.NEXTVAL
            , 'ROLE_WAIT'
            );

-- Menu
DROP SEQUENCE MENU_SEQ;
CREATE SEQUENCE MENU_SEQ START WITH 1 INCREMENT BY 1;
            
INSERT INTO MENU(
                  MENU_NO
                , MENU_NAME
                , URL
                , MENU_PARENT
                )
        VALUES(
                MENU_SEQ.NEXTVAL
              , 'ROOT'
              , '/nos.mm'
              , ''
              );
              
INSERT INTO MENU(
                  MENU_NO
                , MENU_NAME
                , URL
                , MENU_PARENT
                )
        VALUES(
                MENU_SEQ.NEXTVAL
              , '유지보수'
              , '/nos.mm/maintenance'
              , 1
              );

INSERT INTO MENU(
                  MENU_NO
                , MENU_NAME
                , URL
                , MENU_PARENT
                )
        VALUES(
                MENU_SEQ.NEXTVAL
              , '리스트'
              , '/nos.mm/maintenance/list'
              , 2
              );
                            
INSERT INTO MENU(
                  MENU_NO
                , MENU_NAME
                , URL
                , MENU_PARENT
                )
        VALUES(
                MENU_SEQ.NEXTVAL
              , '캘린더'
              , '/nos.mm/maintenance/calendar'
              , 2
              );

INSERT INTO MENU(
                  MENU_NO
                , MENU_NAME
                , URL
                , MENU_PARENT
                )
        VALUES(
                MENU_SEQ.NEXTVAL
              , '고객사'
              , '/nos.mm/management'
              , 1
              );
              
INSERT INTO MENU(
                  MENU_NO
                , MENU_NAME
                , URL
                , MENU_PARENT
                )
        VALUES(
                MENU_SEQ.NEXTVAL
              , '리스트'
              , '/nos.mm/management/clientList'
              , 5
              );
             
INSERT INTO MENU(
                  MENU_NO
                , MENU_NAME
                , URL
                , MENU_PARENT
                )
        VALUES(
                MENU_SEQ.NEXTVAL
              , '내정보'
              , '/nos.mm/mypage'
              , 1
              );
              
-- WORK SCOPE 
Insert into WORK_SCOPE (WORK_SCOPE_NO,WORK_SCOPE_NAME) values (1,'정기점검');
Insert into WORK_SCOPE (WORK_SCOPE_NO,WORK_SCOPE_NAME) values (2,'기술지원');
Insert into WORK_SCOPE (WORK_SCOPE_NO,WORK_SCOPE_NAME) values (3,'프로젝트');
Insert into WORK_SCOPE (WORK_SCOPE_NO,WORK_SCOPE_NAME) values (4,'오류해결');
Insert into WORK_SCOPE (WORK_SCOPE_NO,WORK_SCOPE_NAME) values (5,'인력추가');
Insert into WORK_SCOPE (WORK_SCOPE_NO,WORK_SCOPE_NAME) values (6,'유지보수');
Insert into WORK_SCOPE (WORK_SCOPE_NO,WORK_SCOPE_NAME) values (7,'회의');

-- SUPPORT
Insert into SUPPORT (SUPPORT_NO,SUPPORT_NAME) values (1,'유선');
Insert into SUPPORT (SUPPORT_NO,SUPPORT_NAME) values (2,'방문');
Insert into SUPPORT (SUPPORT_NO,SUPPORT_NAME) values (3,'이메일');
Insert into SUPPORT (SUPPORT_NO,SUPPORT_NAME) values (4,'VPN');
