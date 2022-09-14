-- Data Definition Language
-- DDL
-- (create , alter , drop)

-- TABLE (기본키 , 외래키)
-- 제약 조건을 사용하여 데이터의 무결성을 보장
-- 무결성 : 데이터가 손상되거나 원래의 의미를 잃지 않고 유지하는 상태


/*
NOT NULL
UNIQUE
PRIMARY KEY (NOT NULL + UNIQUE)
REFERENCES (FROEIGN KEY)
CHECK : 해당 컬럼에 특정 조건을 만족하도록 하는 컬럼

테이블 제작 구문 형식
(CREATE TABLE TABLE_NAME(
        COLUMN_NAME DATATYPE(SIZE) [DEFAULT] [CONSTRAINT] 
        COLUMN_NAME DATATYPE(SIZE) [DEFAULT] [CONSTRAINT]
        COLUMN_NAME DATATYPE(SIZE) [DEFAULT] [CONSTRAINT]
                        )
)
*/
-- test
CREATE TABLE NOTNULL_TBL(
    ID      VARCHAR2(20) NOT  NULL ,
    SNAME   VARCHAR2(20)
) ;

-- 입력구문
-- INSERT INTO TABLE_NAME VALUES();

INSERT INTO NOTNULL_TBL VALUES('JSLIM' , '최진형') ;
SELECT  *
FROM    NOTNULL_TBL ;

-- ERROR CASE

INSERT INTO NOTNULL_TBL VALUES(NULL , '최진형') ;
-- -> 오류 NOTNILL_TBL을 지정해주었기 때문에 NULL이 들어갈 수 없다. (test 구문확인)

INSERT INTO NOTNULL_TBL VALUES('최진형' , NULL ) ;
-- -> 오류 없음 test 구문에서 SNAME에는 NOT NULL을 설정하지 않았기 때문

CREATE TABLE PK_TBL(
    ID      VARCHAR2(20)    PRIMARY KEY ,
    SNAME   VARCHAR2(20)
) ;

INSERT INTO PK_TBL VALUES('JUICE' , '최진형') ;
INSERT INTO PK_TBL VALUES('JUICE' , '최진형') ;
SELECT  *
FROM    PK_TBL ;

-- ID에 PRIMARY KEY 를 설정해두면 중복과 NULL 을 인정하지 않는다.



CREATE TABLE PK_TBL2(
    ID      VARCHAR2(20)    ,
    SSN     VARCHAR2(20)    ,
    SNAME   VARCHAR2(20)    ,
    PRIMARY KEY (ID , SSN)
) ;

INSERT INTO PK_TBL2 VALUES('JUICE' , '111' , '최진형') ;
SELECT  *
FROM    PK_TBL2 ;




DELETE FROM PK_TBL ;
DROP TABLE PK_TBL ;


CREATE TABLE DEPT_TBL(
    DEPT_ID         VARCHAR2(50)    PRIMARY KEY ,
    DEPT_NAME       VARCHAR2(50)  
);
INSERT INTO DEPT_TBL VALUES('10', '교육팀');
INSERT INTO DEPT_TBL VALUES('20', '영업팀');
INSERT INTO DEPT_TBL VALUES('30', '인사팀');
SELECT  *
FROM    DEPT_TBL ;

CREATE TABLE JOB_TBL(
    JOB_ID      VARCHAR2(50)    PRIMARY KEY ,
    JOB_TITLE   VARCHAR2(50)  
);
INSERT INTO JOB_TBL VALUES('J1', '대표이사');
INSERT INTO JOB_TBL VALUES('J2', '부장');
INSERT INTO JOB_TBL VALUES('J3', '차장');
INSERT INTO JOB_TBL VALUES('J5', '과장');
INSERT INTO JOB_TBL VALUES('J6', '대리');
INSERT INTO JOB_TBL VALUES('J7', '사원');

SELECT  *
FROM    JOB_TBL ;



-- 외래키
-- [DEFAULT] = NULL값이 들어올 경우 DEFAULT에 설정한 값을 대신 반환
CREATE TABLE EMPLOYEE_TBL(
    EMP_ID      VARCHAR2(50) PRIMARY KEY    ,
    EMP_NAME    VARCHAR2(50)                ,
    HIRE_DATE   DATE DEFAULT SYSDATE        ,       -- 데이터는 DATE형 NULL일 경우 오늘 날짜 입력
    SALARY      NUMBER CHECK( SALARY > 0 )          -- 데이터는 NUMBER 단 SALARY > 0 조건
);



INSERT INTO EMPLOYEE_TBL (EMP_ID , EMP_NAME , SALARY)
VALUES('100' , '최진형' , 10000000) ;
SELECT  *
FROM    EMPLOYEE_TBL ;


-- 테이블 삭제
DROP TABLE EMPLOYEE_TBL ;


-- 외래키


CREATE TABLE EMPLOYEE_TBL(
            EMP_ID      VARCHAR2(50) PRIMARY KEY    
        ,   EMP_NAME    VARCHAR2(50)                
        ,   HIRE_DATE   DATE DEFAULT SYSDATE               
        ,   SALARY      NUMBER CHECK( SALARY > 0 )  
        ,   JOB_ID      VARCHAR2(50) REFERENCES JOB_TBL(JOB_ID)
        ,   DEPT_ID     VARCHAR2(50) REFERENCES DEPT_TBL(DEPT_ID)
);

INSERT INTO EMPLOYEE_TBL (EMP_ID , EMP_NAME , SALARY , JOB_ID , DEPT_ID)
VALUES('JUICE' , '최진형' , 100000000 , 'J2' , '10') ;

SELECT  *
FROM    EMPLOYEE_TBL ;

SELECT  *
FROM    EMPLOYEE_TBL    E 
JOIN    DEPT_TBL        D ON (E.DEPT_ID = D.DEPT_ID)
JOIN    JOB_TBL         J ON (E.JOB_ID = J.JOB_ID)
;






CREATE TABLE COMPOSIT_PK_TBL(
        JOB_ID      VARCHAR2(50)    REFERENCES   JOB_TBL(JOB_ID)
    ,   DEPT_ID     VARCHAR2(50)    REFERENCES   DEPT_TBL(DEPT_ID)
    ,   MSG         VARCHAR2(50)
    ,   PRIMARY KEY (JOB_ID , DEPT_ID)
) ;

CREATE TABLE SUB_TBL(
        TEST_ID     VARCHAR2(50)    PRIMARY KEY 
    ,   JOB_ID      VARCHAR2(50)    
    ,   DEPT_ID     VARCHAR2(50)
    ,   FOREIGN KEY (JOB_ID , DEPT_ID) REFERENCES COMPOSIT_PK_TBL(JOB_ID , DEPT_ID)
) ;
-- 중요 : 다중 REFERENCES를 가진 테이블의 키를 외래키로 가져올 경우 , 하나씩 REFERENCES 는 불가하고 FOREIGN KEY를 사용하여 지정해주어야한다.

SELECT  *
FROM    SUB_TBL ;


-- CREATE [TABLE_NAME] AS [SELECT FROM] 원본 데이터의 클론 개념

CREATE TABLE EMP
AS 
SELECT  *
FROM    EMPLOYEE ;





/*
ALTER TABLE TABLE_NAME

ALTER TABLE TALBE_NAME
ADD [COLUMN_NAME TYPE[DATA] [DEFAULT] [CONSTRAINT]]

ADD (COLIMN_NAME TYPE [DEFAULT] [CONSTRAINT])
테이블에 칼럼을 추가함


ALTER TABLE TALBE_NAME
DROP [COLUMN_NAME]
테이블의 칼럼을 삭제함
DROP TABLE TABLE_NAME
테이블을 삭제함

MODIFY(COLUMN_NAME TYPE [DEFAULT] [CONSTRAINT])
테이블에 있는 칼럼을 변경함

[이름 변경 구문]
테이블 이름 변경
ALTER TABLE OLD_TABLE_NAME RENAME TO NEW_TABLE_NAME ;

칼럼 이름 변경
ALTER TABLE TABLE_NAME RENAME COLUMN OLD_COLUMN TO NEW_COLUMN ;
*/






SELECT  *
FROM    EMP_NAME ;

-- 칼럼 추가

ALTER   TABLE   EMP
ADD (STATUS CHAR(1) DEFAULT 'N') ;


ALTER TABLE EMP
MODIFY  (STATUS VARCHAR2(10) DEFAULT 'Y') ;
-- 디폴드값은 이전에 이미 값이 들어있을 경우 변경이 되지 않는다. NULL 인 경우만 변경

ALTER TABLE EMP
DROP COLUMN STATUS ;



-- 테이블 이름 변경
ALTER TABLE EMP RENAME TO EMP_NAME ;


-- 부모 테이블은 삭제할 수 없다.

DROP TABLE JOB_TBL ;

-- 자식 테이블부터 순차적으로 삭제해야한다.
-- 단 , 조건을 주면 부모 테이블 삭제가 가능하다.

DROP TABLE JOB_TBL  CASCADE CONSTRAINTS ;
DROP TABLE DEPT_TBL  CASCADE CONSTRAINTS ;
DROP TABLE EMP_NAME  CASCADE CONSTRAINTS ;



-- VIEW : VIRTUAL TABLE , STORDE QUERY
-- 구조만 가지고 있는 논리적 테이블
-- 목적 : 부분집합의 논리적 구조 및 쿼리의 단순화를 위해서 사용

/* CREATE OR REPLACE VIEW VIEW_NAME
   AS SUBQUERY */
   
-- 복잡한 서브쿼리 단순화

CREATE OR REPLACE VIEW V_EMP_90
AS
SELECT      EMP_NAME    
        ,   SALARY
        ,   DEPT_ID
FROM        EMPLOYEE
WHERE       DEPT_ID = '90' ;

SELECT     *
FROM        V_EMP_90 ;

CREATE OR REPLACE VIEW V_EMP_GENDER(NAME , GENDER)  -- 별칭 지정 가능
AS
SELECT      EMP_NAME
        ,   CASE SUBSTR(EMP_NO , 8 , 1) 
                WHEN '1' THEN 'MAN'
                WHEN '3' THEN 'MAN'
                ELSE 'WOMAN'
            END
FROM        EMPLOYEE ;


-- 뷰 삭제 : DROP VIEW V_EMP_GENDER ;


-- DROP VIEW V_EMP_GENDER ;

-- 시퀀스(SEQUENCE) : 순차적으로 정수 값을 자동으로 생성하는 객체
/*
NEXTVAL : 새로운 시퀀스 값을 반환
CURVAL : 현재 값을 반환

CREATE SEQUENCE [SEQUENCE_NAME]
INCREMENT BY N      숫자의 증가량(수열)
START WITH N        숫자의 시작 위치
[NOCYCLE]           반복을 할 것인지 (기본 안함)

*/


CREATE  SEQUENCE EMP_SEQ ;
SELECT  EMP_SEQ.NEXTVAL FROM DUAL ;

-- EMP_SEQ 객체 생성 후 객체가 소유하고 있는 속성(NEXTVAL) 반환 - 입력시마다 출력이 바뀌는 것을 볼 수 있다.

SELECT  EMP_SEQ.CURRVAL FROM DUAL ;

-- EMP_SEQ의 현재 값 혹은 속성 반환 (CURRVAL)


CREATE SEQUENCE SEQ_TEST
INCREMENT BY 5              -- 숫자의 증가량(수열)
START WITH  300              -- 숫자의 시작 위치
MAXVALUE    310
NOCYCLE
NOCACHE ;

SELECT  SEQ_TEST.NEXTVAL FROM DUAL ;
SELECT  SEQ_TEST.CURRVAL FROM DUAL ;

-- 시작은 300 최댓값은 310 이므로 310인 경우에 NEXTVAL은 사용이 불가하다.
-- 시퀀스는 PRIMARY KEY에서 많이 사용된다.
-- DROP SEQUENCE SEQUENCE_NAME 시퀀스 삭제

DROP  SEQUENCE SEQ_TEST ;

CREATE SEQUENCE TEST_SEQ ;
CREATE TABLE SEQ_TEST_TBL (
        ID      VARCHAR2(20) PRIMARY KEY
    ,   NAME    VARCHAR2(20)
    ,   SALARY  NUMBER
) ;

INSERT INTO SEQ_TEST_TBL VALUES(
    TO_CHAR(TEST_SEQ.NEXTVAL) , '최진형'  , 100
) ;

SELECT  *
FROM    SEQ_TEST_TBL ;


-- 데이터 수정 구문

/*
UPDATE  TABLE_NAME
SET     COLUMN = VALUE , [COLUMN = VALUE]
WHERE   CONDITION ;
*/

UPDATE  SEQ_TEST_TBL
SET     NAME = '섭섭해' , SALARY = SALARY - 50
WHERE   ID = '1' ;

-- 데이터 삭제 구문
/*DELETE FROM TABLE_NAME
WHERE   CONDITION ; */

DELETE FROM SEQ_TEST_TBL
WHERE   ID = '1' ;




-- INSERT , UPDATE , DELETE (DML) : 데이터 조작어
-- 테이블에 새로운 행을 갱신할 수 있다.



-- UPDATE
/*
UPDATE      TABLE_NAME
SET         COLUMN = VALUE OR DEFAULT(COLUMN에 DEFAULT 있을 경우 사용 가능)  ,   [COLUMN = 서브쿼리]
WHERE       CONDITION ;
*/


-- 90번 부서의 이름을 전략기획팀으로 변경
SELECT      *
FROM        DEPARTMENT ;

UPDATE      DEPARTMENT
SET         DEPT_NAME = '전략기획팀'       
WHERE       DEPT_ID = '90' ;


-- 심하균 사원의 직급과 급여를 성해교 사원의 사원과 같은 것으로 수정한다


SELECT      *
FROM        EMPLOYEE ;

SELECT      *
FROM        JOB ;

UPDATE      EMPLOYEE
SET         SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '성해교')
        ,   JOB_ID = (SELECT JOB_ID FROM EMPLOYEE WHERE EMP_NAME = '성해교') 
WHERE       EMP_NAME = '심하균' ;

SELECT      JOB_ID , SALARY
FROM        EMPLOYEE
WHERE       EMP_NAME = '성해교' OR EMP_NAME = '심하균' ;

-- DEFAULT를 이용한 업데이트
UPDATE  EMPLOYEE
SET     MARRIAGE = DEFAULT
WHERE   EMP_NAME = '심하균' ;

SELECT      *
FROM        EMPLOYEE 
;


-- 해외 영업 2팀의 직원의 보너스 비율을 업데이트 0.3


UPDATE  EMPLOYEE
SET     BONUS_PCT = 0.3
WHERE   DEPT_ID = 
(   SELECT      DEPT_ID
    FROM        DEPARTMENT
    WHERE       DEPT_NAME = '해외영업2팀') ;

SELECT      DEPT_ID
FROM        DEPARTMENT
WHERE       DEPT_NAME = '해외영업2팀' ;


-- UPDATE시 부모키의 값에 자식키는 의존한다. 따라서 자식키 변경시 부모키에 명시된 값만을 사용해야한다.

-- INSERT
-- 구문 (데이터의 타입 , 순서 , 개수 일치)
/*
INSERT INTO TABLE_NAME([COLUMN_NAME])
VALUES (VALUE) ;
*/

-- INSERT 데이터 입력시 , 데이터 입력을 생략하면 묵시적 NULL 값이 입력된다.
-- 반면 인위적으로 NULL 값을 입력하면 명시적 NULL 할당이 된다. 반면 DEFAULT 값이 존재할 경우 DEFAULT로 줄 수도 있다.


CREATE TABLE EMP_INFO_TBL (
        EMP_ID      CHAR(3)
    ,   EMP_NAME    VARCHAR2(20)
    ,   DEPT_NAME   VARCHAR2(20)
) ;

-- VALUE 대신 서브쿼리가 사용가능
-- ROLEBACK = CONTORL + Z
-- DELETE

/*
DELETE FROM TABLE_NAME
WHERE  [] 
TRUNCATE TABLE TABLE_NAME (ROLLBACK 불가)
*/

DELETE FROM EMP_INFO_TBL ;

-- 부모키 무시하고 삭제 DROP/DELETE TABLE_NAME CASCADE CONSTRAINTS

-- ON DELETE SET NULL   부모키 삭제시 자식은 NULL 값 대체
-- ON DELETE CASCADE    부모키 삭제시 자식도 삭제

ALTER 	TABLE EMPLOYEE
DROP 	CONSTRAINTS FK_JOBID ; 


ALTER 	TABLE EMPLOYEE
ADD		CONSTRAINTS FK_JOBID FOREIGN KEY(JOB_ID) 
REFERENCES JOB ON DELETE SET NULL ;


SELECT  *
FROM    EMPLOYEE ;



-- 트랜잭션 : 데이터의 일관성을 유지하기 위해서 사용하는 논리적인 작업의 집합
-- ROLLBACK , COMMIT ;

/*

SQL > INSERT INTO ~ 트랜젝션 시작
SQL > UPDATE
SQL > COMMIT ;      트랜젝션 종료

SQL > INSERT INTO ~ 트랜젝션 시작
SQL > UPDATE
SQL > CREATE OR REPLACE VIEW ~ DDL 구문에 의한 자동 COMMIT 커밋이 되면 롤백이 불가

*/

-- LOCK













