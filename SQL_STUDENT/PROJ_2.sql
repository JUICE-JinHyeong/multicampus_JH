-- 1

-- MEMBER

CREATE TABLE MEMBER (
        MEMBER_ID   NUMBER(10)          PRIMARY KEY
    ,   NAME        VARCHAR2(25)        NOT NULL
    ,   ADDRESS     VARCHAR2(100)       
    ,   CITY        VARCHAR2(30)    
    ,   PHONE       VARCHAR2(15)
    ,   JOIN_DATE   DATE DEFAULT SYSDATE NOT NULL
) ;

SELECT  *
FROM    MEMBER ;

-- TITLE

CREATE TABLE TITLE (
        TITLE_ID    NUMBER(10)          PRIMARY KEY
    ,   TITLE       VARCHAR2(60)        NOT NULL
    ,   DESCRIPTION VARCHAR2(400)       NOT NULL
    ,   RATING      VARCHAR2(20) CHECK (RATING IN ('18가' , '15가' , '12가' , '전체가'))
    ,   CATEGORY    VARCHAR2(20) CHECK (CATEGORY IN ('드라마' , '액션' , '코미디' , '아동' , 'SF' , '다큐멘터리'))
    ,   RELEASE_DATE    DATE
) ;

SELECT  *
FROM    TITLE ;
DROP TABLE TITLE;
ALTER TABLE TITLE RENAME COLUMN RELESASE TO RELEASE_DATE ;
-- TITLE_COPY

CREATE TABLE TITLE_COPY (
            COPY_ID     NUMBER(10)
        ,   TITLE_ID    NUMBER(10)          REFERENCES TITLE (TITLE_ID)
        ,   STATUS      VARCHAR2(20) CHECK (STATUS IN ('대여가능' , '파손' , '대여중' , '예약')) NOT NULL 
        ,   PRIMARY KEY (COPY_ID , TITLE_ID) 
) ;

SELECT  *
FROM    TITLE_COPY ;
DROP TABLE TITLE_COPY ;
    
-- RENTAL

CREATE TABLE RENTAL (
            BOOK_DATE       DATE DEFAULT SYSDATE
        ,   MEMBER_ID       NUMBER(10)      REFERENCES MEMBER(MEMBER_ID)
        ,   COPY_ID         NUMBER(10)      
        ,   TITLE_ID        NUMBER(10)      
        ,   ACT_RET_DATE    DATE
        ,   EXP_RET_DATE    DATE DEFAULT SYSDATE+2
        ,   PRIMARY KEY     (BOOK_DATE , MEMBER_ID , COPY_ID , TITLE_ID)
        ,   FOREIGN KEY     (COPY_ID , TITLE_ID) REFERENCES TITLE_COPY(COPY_ID , TITLE_ID)
) ;        
        

SELECT  *
FROM    RENTAL ;

DROP TABLE RENTAL ;

-- RESERVATION

CREATE TABLE RESERVATION (
            RES_DATE        DATE
        ,   MEMBER_ID       NUMBER(10)      REFERENCES MEMBER(MEMBER_ID)
        ,   TITLE_ID        NUMBER(10)      REFERENCES TITLE(TITLE_ID)
        ,   PRIMARY KEY     (RES_DATE , MEMBER_ID , TITLE_ID)
) ;

SELECT  *
FROM    RESERVATION ;
        
DROP TABLE RESERVATION ;


-- 2
/*
CREATE SEQUENCE SEQ_TEST
INCREMENT BY 5              -- 숫자의 증가량(수열)
START WITH  300              -- 숫자의 시작 위치
MAXVALUE    310
NOCYCLE
NOCACHE ;
*/

-- A

CREATE SEQUENCE MEMBER_ID_SEQ 
INCREMENT BY 1
START WITH 101
NOCYCLE
NOCACHE ;
DROP SEQUENCE MEMBER_ID_SEQ ;

-- B

CREATE SEQUENCE TITLE_ID_SEQ
INCREMENT BY 1
START WITH 92
NOCYCLE
NOCACHE ;

DROP SEQUENCE TITLE_ID_SEQ ;
        

-- 3


INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '인어공주'
    ,   '인어공주 설명'
    ,   '전체가'
    ,   '아동'
    ,   '95/10/05'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '메트릭스'
    ,   '매트릭스 설명'
    ,   '15가'
    ,   'SF'
    ,   '95/05/19'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '에이리언'
    ,   '에이리언 설명'
    ,   '18가'
    ,   'SF'
    ,   '95/08/12'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '모던타임즈'
    ,   '모던타임즈 설명'
    ,   '전체가'
    ,   '코미디'
    ,   '95/07/12'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '러브스토리'
    ,   '러브스토리 설명'
    ,   '전체가'
    ,   '드라마'
    ,   '95/09/12'
) ;
INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '람보'
    ,   '람보 설명'
    ,   '18가'
    ,   '액션'
    ,   '95/06/01'
) ;
SELECT *
FROM    TITLE ;
        
        
-- 4

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '김철수'
    ,   '강남구'
    ,   '서울'
    ,   '899-6666'
    ,   '90/03/08'
) ;

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '이영희'
    ,   '서면'
    ,   '부산'
    ,   '355-8882'
    ,   '90/03/08'
) ;

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '최진국'
    ,   '동광양'
    ,   '제주'
    ,   '852-5764'
    ,   '91/06/17'
) ;

INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '강준호'
    ,   '홍제동'
    ,   '강릉'
    ,   '559-7777'
    ,   '90/04/07'
) ;
        
INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '민병국'
    ,   '전민동'
    ,   '대전'
    ,   '559-8741'
    ,   '91/01/18'
) ;
INSERT INTO MEMBER VALUES (
        MEMBER_ID_SEQ.NEXTVAL
    ,   '오민수'
    ,   '북구'
    ,   '광주'
    ,   '542-9988'
    ,   '91/01/18'
) ;
SELECT  *
FROM    MEMBER ;


-- 5

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '인어공주')
    ,   '대여가능'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '매트릭스')
    ,   '대여가능'
) ;

UPDATE  TITLE
SET     TITLE = '매트릭스'
WHERE   TITLE_ID = 93;

-- 매트릭스를 메트릭스라고 적어서 고침

INSERT INTO TITLE_COPY VALUES (
        2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '매트릭스')
    ,   '대여중'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '에이리언')
    ,   '대여가능'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈')
    ,   '대여가능'
) ;

INSERT INTO TITLE_COPY VALUES (
        2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈')
    ,   '대여가능'
) ;

INSERT INTO TITLE_COPY VALUES (
        3
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈')
    ,   '대여중'
) ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '러브스토리')
    ,   '대여가능'
) ;


INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '람보')
    ,   '대여가능'
) ;

SELECT  *
FROM    TITLE_COPY ;


-- 6

INSERT INTO RENTAL VALUES (
        SYSDATE - 3
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '김철수')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '인어공주')
    ,   SYSDATE - 2
    ,   SYSDATE - 1
) ;     

INSERT INTO RENTAL VALUES (
        SYSDATE - 1
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '최진국')
    ,   2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '매트릭스')
    ,   NULL
    ,   SYSDATE + 1
) ;  

UPDATE  RENTAL
SET     ACT_RET_DATE = SYSDATE - 2 , EXP_RET_DATE = SYSDATE - 1
WHERE   MEMBER_ID = 101 ;
UPDATE  RENTAL
SET     ACT_RET_DATE = NULL , EXP_RET_DATE = SYSDATE + 1
WHERE   MEMBER_ID = 103 ;


INSERT INTO RENTAL VALUES (
        SYSDATE - 2
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '강준호')
    ,   3
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '모던타임즈')
    ,   NULL
    ,   SYSDATE
) ;  

INSERT INTO RENTAL VALUES (
        SYSDATE - 4
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '민병국')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '람보')
    ,   SYSDATE - 2
    ,   SYSDATE - 2
) ;        

SELECT  *
FROM    RENTAL ;

        
        
        
-- 7


SELECT      T.TITLE         AS "TITLE"
        ,   CP.COPY_ID      AS "COPY_ID"
        ,   CP.STATUS       AS "STATUS"
        ,   R.EXP_RET_DATE  AS "EXP_RET_DATE"
FROM        TITLE       T
LEFT JOIN        TITLE_COPY  CP  ON (T.TITLE_ID = CP.TITLE_ID)
LEFT JOIN        RENTAL      R   ON (CP.COPY_ID = R.COPY_ID AND CP.TITLE_ID = R.TITLE_ID) -- CP.TITLE_ID = R.TITLE_ID CP.COPY_ID = R.COPY_ID
ORDER BY    T.TITLE_ID , CP.COPY_ID  ;


            
SELECT  *
FROM    TITLE ;
SELECT  *
FROM    RENTAL ;
SELECT  *
FROM    TITLE_COPY ;
            
            
            
            
CREATE OR REPLACE VIEW TITLE_AVAIL (TITLE , COPY_ID , STATUS , EXP_RET_DATE)
AS
SELECT      T.TITLE         AS "TITLE"
        ,   CP.COPY_ID      AS "COPY_ID"
        ,   CP.STATUS       AS "STATUS"
        ,   R.EXP_RET_DATE  AS "EXP_RET_DATE"
FROM        TITLE       T
LEFT JOIN        TITLE_COPY  CP  ON (T.TITLE_ID = CP.TITLE_ID)
LEFT JOIN        RENTAL      R   ON (CP.COPY_ID = R.COPY_ID AND CP.TITLE_ID = R.TITLE_ID) 
ORDER BY    T.TITLE_ID , CP.COPY_ID  ;            
            

SELECT      *
FROM        TITLE_AVAIL ;




-- 8 

-- A

INSERT INTO TITLE VALUES (
        TITLE_ID_SEQ.NEXTVAL
    ,   '스타워즈'
    ,   '스타워즈 설명'
    ,   '전체가'
    ,   'SF'
    ,   '77/07/07'
) ;

SELECT  *
FROM    TITLE ;

INSERT INTO TITLE_COPY VALUES (
        1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈')
    ,   '대여가능'
) ;

INSERT INTO TITLE_COPY VALUES (
        2
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈')
    ,   '대여가능'
) ;

SELECT  *
FROM    TITLE_COPY ;



-- B


INSERT INTO RESERVATION VALUES (
        SYSDATE
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '이영희')
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈')
) ;

INSERT INTO RESERVATION VALUES (
        SYSDATE
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '오민수')
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '러브스토리')
) ;
   
SELECT  *
FROM    RESERVATION ;


-- C


-- 삭제
DELETE RESERVATION 
WHERE  MEMBER_ID = 102 ;
-- 대여정보

INSERT INTO RENTAL VALUES (
        SYSDATE 
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '이영희')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈')
    ,   SYSDATE
    ,   DEFAULT
) ;  


INSERT INTO RENTAL VALUES (
        SYSDATE 
    ,   (SELECT MEMBER_ID FROM MEMBER WHERE NAME = '이영희')
    ,   1
    ,   (SELECT TITLE_ID FROM TITLE WHERE TITLE = '스타워즈')
    ,   SYSDATE
    ,   DEFAULT
) ;  

UPDATE  TITLE_COPY
SET     STATUS = '대여중'
WHERE   TITLE_ID = 98 ;

UPDATE  TITLE_COPY
SET     STATUS = '대여가능'
WHERE   TITLE_ID = 98 AND COPY_ID = '2';

SELECT  *
FROM    TITLE_COPY ;



SELECT      *
FROM        TITLE_AVAIL ;  -- 뷰



-- 9

-- 칼럼 생성

ALTER TABLE TITLE ADD (PRICE NUMBER(5)) ;

-- 칼럼에 데이터 입력




UPDATE  TITLE
SET     PRICE = 3000 
WHERE   TITLE = '인어공주' ;

UPDATE  TITLE
SET     PRICE = 2500 
WHERE   TITLE = '매트릭스' ;

UPDATE  TITLE
SET     PRICE = 2000 
WHERE   TITLE = '에이리언' ;

UPDATE  TITLE
SET     PRICE = 3000 
WHERE   TITLE = '모던타임즈' ;

UPDATE  TITLE
SET     PRICE = 3500 
WHERE   TITLE = '러브스토리' ;

UPDATE  TITLE
SET     PRICE = 2000 
WHERE   TITLE = '람보' ;

UPDATE  TITLE
SET     PRICE = 1500 
WHERE   TITLE = '스타워즈' ;

SELECT *
FROM    TITLE ;


-- PRICE 칼럼에 NOT NULL

ALTER TABLE TITLE
MODIFY (PRICE NUMBER(5) NOT NULL) ;



-- 10



SELECT      M.NAME          AS "회원명"
        ,   T.TITLE         AS "제목"
        ,   R.BOOK_DATE     AS "대여일"
        ,   NVL (ROUND(R.ACT_RET_DATE - R.BOOK_DATE) , 0)     AS "기간"        
FROM        TITLE       T
JOIN        TITLE_COPY  CP  ON (T.TITLE_ID = CP.TITLE_ID)
JOIN        RENTAL      R   ON (CP.COPY_ID = R.COPY_ID AND CP.TITLE_ID = R.TITLE_ID) 
JOIN        MEMBER      M   ON (R.MEMBER_ID = M.MEMBER_ID)  
ORDER BY    T.TITLE_ID , CP.COPY_ID  ; 


SELECT  *
FROM    RENTAL ;
SELECT  *
FROM    TITLE_COPY ;