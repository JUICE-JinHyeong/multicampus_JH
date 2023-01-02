-- 1
-- customers
CREATE TABLE CUSTOMERS (
        CNO     NUMBER(5)       PRIMARY KEY
    ,   CNAME   VARCHAR2(10)    NOT NULL 
    ,   ADDRESS VARCHAR2(50)    NOT NULL
    ,   EMAIL   VARCHAR2(20)    NOT NULL
    ,   PHONE   VARCHAR2(20)    NOT NULL
) ;

SELECT *
FROM CUSTOMERS ;
-- DROP TABLE CUSTOMERS ;

-- orders
CREATE TABLE ORDERS (
        ORDERNO     NUMBER(10)              PRIMARY KEY
    ,   ORDERDATE   DATE DEFAULT SYSDATE    NOT NULL 
    ,   ADDRESS     VARCHAR2(50)            NOT NULL
    ,   PHONE       VARCHAR2(20)            NOT NULL
    ,   STATUS      VARCHAR2(20) CHECK (
                                        STATUS LIKE '결제완료' OR STATUS LIKE '배송중' OR STATUS LIKE '배송완료'
                                        )   NOT NULL
    ,   CNO         NUMBER(5)               NOT NULL
                                            REFERENCES CUSTOMERS(CNO)
) ;

SELECT  *
FROM    ORDERS ;

-- products

CREATE TABLE PRODUCTS (
        PNO     NUMBER(5)           PRIMARY KEY
    ,   PNAME   VARCHAR2(20)        NOT NULL
    ,   COST    NUMBER(8) DEFAULT 0 NOT NULL
    ,   STOCK   NUMBER(5) DEFAULT 0 NOT NULL
) ;    
SELECT  *
FROM    PRODUCTS ;



-- ordertail

CREATE TABLE ORDERTAIL (
        ORDERNO     NUMBER(10)          REFERENCES ORDERS(ORDERNO)
    ,   PNO         NUMBER(5)           REFERENCES PRODUCTS(PNO)
    ,   QTY         NUMBER(5) DEFAULT 0
    ,   COST        NUMBER(8) DEFAULT 0
    ,   PRIMARY KEY (ORDERNO , PNO)
) ;

SELECT  *
FROM    ORDERTAIL ;

-- 2


INSERT INTO PRODUCTS VALUES (1001 , '삼양라면' , 1000 , 200) ;
INSERT INTO PRODUCTS VALUES (1002 , '새우깡' , 1500 , 500) ;
INSERT INTO PRODUCTS VALUES (1003 , '월드콘' , 2000 , 350) ;
INSERT INTO PRODUCTS VALUES (1004 , '빼빼로' , 2000 , 700) ;
INSERT INTO PRODUCTS VALUES (1005 , '코카콜라' , 1800 , 550) ;
INSERT INTO PRODUCTS VALUES (1006 , '환타' , 1600 , 300) ;


SELECT  *
FROM    PRODUCTS ;


-- 3

INSERT INTO CUSTOMERS VALUES (101 , '김철수' , '서울 강남구' , 'cskim@naver.com' , '899-6666') ;
INSERT INTO CUSTOMERS VALUES (102 , '이영희' , '부산 서면' , 'yhlee@empal.com' , '355-8882') ;
INSERT INTO CUSTOMERS VALUES (103 , '최진국' , '제주 동광양' , 'jkchoi@gmail.com' , '852-5764') ;
INSERT INTO CUSTOMERS VALUES (104 , '강준호' , '강릉 홍제동' , 'jhkang@hanmail.com' , '559-7777') ;
INSERT INTO CUSTOMERS VALUES (105 , '민병국' , '대전 전민동' , 'bgmin@hotmail.com' , '559-8747') ;
INSERT INTO CUSTOMERS VALUES (106 , '오민수' , '광주 북구' , 'msoh@microsoft.com' , '542-9988') ;

SELECT  *
FROM    CUSTOMERS ;

-- 4 '김철수(101) 가 3일 전에 삼양라면(1001)을 개당 1천원에 50개 주문하였다.'

SELECT      CNO
FROM        CUSTOMERS 
WHERE       CNAME = '김철수';

SELECT  SYSDATE -3
FROM DUAL ;

INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            1
        ,   SYSDATE - 3
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '김철수' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '김철수' )
        ,   '결제완료'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '김철수' )
 ) ;

SELECT  *
FROM    ORDERS ;

INSERT INTO ORDERTAIL VALUES ( 1 , 1001 , 50 , 1000) ;


SELECT  DISTINCT *
FROM    ORDERTAIL ;          

SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
LEFT JOIN        ORDERS          O  ON (C.CNO = O.CNO)
LEFT JOIN        ORDERTAIL       OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) 
WHERE       C.CNAME = '김철수' ;
--
CREATE TABLE CALCULATE
AS
SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERTAIL       OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;
--


-- 5

UPDATE      PRODUCTS
SET         STOCK = 150 
WHERE       PNAME = '삼양라면' ;

SELECT  *
FROM    PRODUCTS ;


-- 6



INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            2
        ,   SYSDATE - 2
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '이영희' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '이영희' )
        ,   '결제완료'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '이영희' )
 ) ;
 
INSERT INTO ORDERTAIL VALUES ( 2 , 1002 , 100 , 1500) ;
INSERT INTO ORDERTAIL VALUES ( 2 , 1003 , 150 , 2000) ;
 SELECT     *
 FROM       ORDERS ;
 SELECT     *
 FROM       ORDERTAIL ;
 
 
SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL       OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;


-- 7


UPDATE      PRODUCTS
SET         STOCK = 500 - 400 
WHERE       PNAME = '새우깡' ;

UPDATE      PRODUCTS
SET         STOCK = 350 - 150  
WHERE       PNAME = '월드콘' ;


SELECT  *
FROM    PRODUCTS ;

-- 8

ALTER TABLE ORDERTAIL RENAME TO ORDERDETAIL ;

SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;


INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            3
        ,   SYSDATE - 1
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '오민수' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '오민수' )
        ,   '결제완료'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '오민수' )
 ) ;

INSERT INTO ORDERDETAIL VALUES ( 3 , 1004 , 100 , 2000) ;
INSERT INTO ORDERDETAIL VALUES ( 3 , 1005 , 50 , 1800) ;

 SELECT     *
 FROM       ORDERS ;
 
 
 
-- 9

UPDATE      PRODUCTS
SET         STOCK = 700 - 100
WHERE       PNAME = '빼빼로' ;

UPDATE      PRODUCTS
SET         STOCK = 550 - 50  
WHERE       PNAME = '코카콜라' ;


SELECT  *
FROM    PRODUCTS ;


-- 10


CREATE OR REPLACE VIEW V_SHOPPING (ORDERNO , ORDERDATE , CNAME , ADDRESS , PHONE , STATUS , PNAME , COST , QTY , SUM)
AS
SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
        ,   P.COST * OT.QTY 
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;


SELECT  *
FROM    V_SHOPPING ;
-- 11


SELECT      O.ORDERDATE
        ,   P.COST * OT.QTY AS "SUM"
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;



-- 12


INSERT INTO PRODUCTS VALUES(
            1007 
        ,   '목캔디'
        ,   3000
        ,   500
) ;

SELECT  *
FROm    PRODUCTS ;

-- 13

INSERT INTO ORDERS (ORDERNO , ORDERDATE , ADDRESS , PHONE , STATUS , CNO) VALUES (
            4
        ,   SYSDATE 
        ,   ( SELECT ADDRESS FROM CUSTOMERS WHERE CNAME = '최진국' )
        ,   ( SELECT PHONE FROM CUSTOMERS WHERE CNAME = '최진국' )         -- 전화번호가 1번에서 입력한 값이랑 틀리다. 그냥 기존 전화번호로 넣음
        ,   '결제완료'
        ,   ( SELECT CNO FROM CUSTOMERS WHERE CNAME = '최진국' )
 ) ;

SELECT  *
FROm    ORDERS ;

UPDATE      PRODUCTS
SET         STOCK = 500 - 200
WHERE       PNAME = '목캔디' ;

INSERT INTO ORDERDETAIL VALUES ( 4 , 1007 , 200 , 3000) ;

SELECT      O.ORDERNO
        ,   O.ORDERDATE
        ,   C.CNAME
        ,   C.ADDRESS
        ,   C.PHONE
        ,   O.STATUS
        ,   P.PNAME
        ,   P.COST
        ,   OT.QTY
        ,   P.COST * OT.QTY 
FROM        CUSTOMERS       C
JOIN        ORDERS          O  ON (C.CNO = O.CNO)
JOIN        ORDERDETAIL     OT ON (O.ORDERNO = OT.ORDERNO AND OT.ORDERNO = O.ORDERNO)
JOIN        PRODUCTS        P  ON (OT.PNO = P.PNO) ;

SELECT  *
FROM    V_SHOPPING ;



CREATE TABLE CART_MILK_YOGURT (
        CART_ID_NO  NUMBER(5)
    ,   NAME_MILK   VARCHAR2(10)
    ,   NAME_YOUGRT VARCHAR2(10)
);
