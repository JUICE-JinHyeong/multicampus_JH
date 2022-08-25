-- JOIN , SUBQUERY

/*
JOIN : 업무적 연관성을 가지고 있고 서로 다른 테이블에 존재하는 컬럼들을 한 번에 조회하기 위한 기법
EQUAL - JOIN
- 조건으로 = 사용하는 구문
NON EQUAL - JOIN
- 조건으로 = 사용하지 않는 구문
*/

-- 오라클 전용 구문

SELECT  *
FROM    DEPARTMENT ;

SELECT  *
FROM    EMPLOYEE ;

-- 비정상적인 JOIN 예시

SELECT  EMP_NAME ,  
        DEPT_NAME 
FROM    EMPLOYEE , DEPARTMENT ;

-- JOIN은 반드시 조건(WHERE)가 필요하다.

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    EMPLOYEE E , DEPARTMENT D , JOB J
WHERE   E.DEPT_ID = D.DEPT_ID AND J.JOB_ID = E.JOB_ID ;

-- ANSI 표준 구문 (USING , ON)
-- USING    : 부모의 기본키와 자식의 외래키의 칼럼 이름이 동일할 때 사용 가능하다.
-- USING 테이블 별칭을 사용할 수 없다.
-- ON       : 부모의 기본키와 자식의 외래키 칼럼이 동일하지 않을 때   

SELECT  EMP_NAME ,  
        DEPT_NAME ,
        JOB_TITLE
FROM    EMPLOYEE E
JOIN    DEPARTMENT D USING(DEPT_ID) 
JOIN    JOB J USING(JOB_ID) 
WHERE   JOB_ID = 'J6' ;


SELECT      JOB_TITLE   ,
            AVG(SALARY)
FROM        EMPLOYEE E
JOIN        DEPARTMENT D USING(DEPT_ID) 
JOIN        JOB J USING(JOB_ID) 
GROUP BY    JOB_TITLE ;

-- ON 사용

SELECT  DEPT_NAME ,
        LOC_DESCRIBE
FROM    DEPARTMENT D
JOIN    LOCATION L ON(LOCATION_ID = LOC_ID) ;

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

-- DEPT_ID에 NULL이 존재하므로 결과 출력이 누락된다.

-- 누락된 데이터 표출시키는법
-- OUTER JOIN ( LEFT | RIGHT | FULL )
SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
RIGHT JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
LEFT JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

SELECT  EMP_NAME ,
        DEPT_NAME
FROM    DEPARTMENT D
FULL JOIN    EMPLOYEE   E ON(D.DEPT_ID = E.DEPT_ID) ;

-- 사원이 어떤 급여 등급에 해당하는지 확인

SELECT   *
FROM     SAL_GRADE ;


SELECT  EMP_NAME ,
        SALARY   ,
        SLEVEL
FROM    EMPLOYEE  E
JOIN    SAL_GRADE S ON(SALARY BETWEEN LOWEST AND HIGHEST) ;


-- SELP JOIN
-- 사원의 이름과 사수의 이름을 조회

SELECT  E.EMP_NAME ,
        NVL(S.EMP_NAME , '*관리자') AS "관리자 명 및 관리자"
FROM    EMPLOYEE E
LEFT JOIN    EMPLOYEE S  ON(E.MGR_ID = S.MGR_ID) ;


-- JOB , EMPLOYEE , DEPARTMENT에서 칼럼 가져오기

SELECT  JOB_TITLE    AS "직무"         ,
        EMP_NAME     AS "사원 이름"     ,
        DEPT_NAME    AS "사무명"        ,
        SLEVEL       AS "급여 등급"     ,
        LOC_DESCRIBE AS "거주 지역"     ,
        COUNTRY_NAME AS "거주 국가"
FROM    EMPLOYEE   A                                       -- 논리 관계에서 부적합한 칼럼은 FROM에 올 수 없다. 
FULL JOIN    JOB        B ON(A.JOB_ID = B.JOB_ID) 
FULL JOIN    DEPARTMENT C ON(A.DEPT_ID = C.DEPT_ID)
JOIN    SAL_GRADE  D ON(SALARY BETWEEN LOWEST AND HIGHEST) -- 외부 칼럼
FULL JOIN    LOCATION   E ON(C.LOC_ID = E.LOCATION_ID)
FULL JOIN    COUNTRY    F ON(E.COUNTRY_ID = F.COUNTRY_ID) 
ORDER BY "급여 등급" ;


-- 위 결과를 가지고 직급이 대리, 지역이 아시아로 시작하는 사원 정보 조회


SELECT    JOB_TITLE    AS "직급"         
        , EMP_NAME     AS "사원 이름"    
        , DEPT_NAME    AS "사무명"       
        , SLEVEL       AS "급여 등급"     
        , LOC_DESCRIBE AS "거주 지역"     
        , COUNTRY_NAME AS "거주 국가"
FROM    EMPLOYEE   A                                       -- 논리 관계에서 부적합한 칼럼은 FROM에 올 수 없다. 
JOIN    JOB        B ON(A.JOB_ID = B.JOB_ID) 
JOIN    DEPARTMENT C ON(A.DEPT_ID = C.DEPT_ID)
JOIN    SAL_GRADE  D ON(SALARY BETWEEN LOWEST AND HIGHEST) -- 외부 칼럼
JOIN    LOCATION   E ON(C.LOC_ID = E.LOCATION_ID)
JOIN    COUNTRY    F ON(E.COUNTRY_ID = F.COUNTRY_ID) 
WHERE   JOB_TITLE = '대리' AND LOC_DESCRIBE LIKE '아시아%'  -- 조건을 줄 때, 별칭은 사용하지 않아도 된다. 별칭은 칼럼 이름 앞글자
ORDER BY "급여 등급" ;




-- 1 학생 이름과 주소지 표시, 출력 헤더 : 학생 이름 , 주소지 , 정렬은 이름으로 오름차

SELECT      STUDENT_NAME        AS "학생 이름"
        ,   STUDENT_ADDRESS     AS "주소지"
FROM        TB_STUDENT
ORDER BY    1 ;


-- 2 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력

SELECT      STUDENT_NAME        AS "학생 이름"
        ,   STUDENT_SSN         AS "학생 주민번호"
FROM        TB_STUDENT
WHERE       ABSENCE_YN = 'Y'
ORDER BY    2 DESC ;

-- 3  주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차 순으로 화면에 출력
--      단 출력 헤더에는 학생이름, 학번 , 거주지 주소가 출력 - 별칭

SELECT      STUDENT_NAME        AS "학생 이름"
        ,   STUDENT_NO          AS "학생 번호"
        ,   STUDENT_ADDRESS 
FROM        TB_STUDENT
WHERE       SUBSTR(STUDENT_NO , 1 , 1) = '9' AND (STUDENT_ADDRESS LIKE '강원%' OR STUDENT_ADDRESS LIKE '경기%')
ORDER BY    1 ;

-- 4 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성

SELECT      PROFESSOR_NAME 
FROM        TB_PROFESSOR
ORDER BY    PROFESSOR_SSN ;

-- 5 2004년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회 , 학점이 높은 학생부터 표시 , 학점이 같으면 학번이 낮은 학생부터 표시

SELECT      STUDENT_NO
        ,   POINT
FROM        TB_GRADE
WHERE       CLASS_NO = 'C3118100'
ORDER BY    POINT , STUDENT_NO ;

-- 6 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬

SELECT      STUDENT_NO          AS "학생 번호"
        ,   STUDENT_NAME        AS "학생 이름"
        ,   DEPARTMENT_NAME     AS "학과 이름"
FROM        TB_DEPARTMENT D
JOIN        TB_STUDENT S ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO) ;

-- 7 춘 기술대의 과목 이름과 과목의 학과 이름을 출력

SELECT      CLASS_NAME          AS "과목"
        ,   DEPARTMENT_NAME     AS "학과"
FROM        TB_DEPARTMENT D
JOIN        TB_CLASS C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO) ;

-- 8 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하라


SELECT      CLASS_NAME          AS "과목"
        ,   PROFESSOR_NAME      AS "교수"
        ,   C. CLASS_NO
FROM        TB_CLASS            C
JOIN        TB_CLASS_PROFESSOR  CP ON(CP.CLASS_NO = C.CLASS_NO)
JOIN        TB_PROFESSOR        P  ON(P.PROFESSOR_NO = CP.PROFESSOR_NO)
ORDER BY    C.CLASS_NO ;


SELECT      CLASS_NAME          AS "과목"
        ,   PROFESSOR_NAME      AS "교수"
FROM        TB_PROFESSOR    P
JOIN        TB_DEPARTMENT   D ON(P.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN        TB_CLASS        C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO) 
GROUP BY    CLASS_NAME , PROFESSOR_NAME
ORDER BY    "과목" , "교수" ;


SELECT  *
FROM    TB_CLASS ;
SELECT  *
FROM    TB_PROFESSOR 
ORDER BY professor_name;
SELECT  *
FROM    TB_CLASS_PROFESSOR 
ORDER BY professor_no;
SELECT  *
FROM    TB_DEPARTMENT ;
-- 9 8번의 결과 중 인문사회 계열에 속한 과목의 교수 이름을 찾으려고 한다. 해당하는 과목 이름과 교수 이름을 출력

SELECT      CLASS_NAME          AS "과목"
        ,   PROFESSOR_NAME      AS "교수"
        ,   CATEGORY            AS "계열"
FROM        TB_DEPARTMENT D
JOIN        TB_CLASS C ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO) 
JOIN        TB_PROFESSOR P ON(D.DEPARTMENT_NO = P.DEPARTMENT_NO)
WHERE       CATEGORY = '인문사회'
ORDER BY    "교수" ;

-- 10 음악학과 학생들의 평점을 구하려고한다. 음악학과 학생들의 학번 이름 전체 평점을 출력

SELECT      S.STUDENT_NO            AS "학번"
        ,   S.STUDENT_NAME          AS "학생 이름"
        ,   ROUND(AVG(G.POINT), 1)  AS "전체 평점"
FROM        TB_STUDENT      S
JOIN        TB_DEPARTMENT   D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
JOIN        TB_GRADE        G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE       DEPARTMENT_NAME = '음악학과' 
GROUP BY    S.STUDENT_NO , S.STUDENT_NAME ;

/* 11 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름
        학생 이름과 지도 교수 이름이 필요하다
        출력헤더는 학과이름 학생이름 지도교수 이름으로 출력되도록 한다. */
SELECT      DISTINCT 
            D.DEPARTMENT_NAME
        ,   S.STUDENT_NAME
        ,   P.PROFESSOR_NAME
FROM        TB_DEPARTMENT   D
JOIN        TB_STUDENT      S ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO)
JOIN        TB_PROFESSOR    P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE       STUDENT_NO = 'A313047' ;

-- 12 2007년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강한 학기를 표시하세요
-- GRADE , STUDENT , CLASS

SELECT      *
FROM        TB_GRADE ;

SELECT      S.STUDENT_NAME
        ,   G.TERM_NO
        ,   C.CLASS_NAME
FROM        TB_GRADE    G
JOIN        TB_STUDENT  S ON(G.STUDENT_NO = S.STUDENT_NO)
JOIN        TB_CLASS    C ON(G.CLASS_NO = C.CLASS_NO)
WHERE       G.TERM_NO LIKE '2007%' AND C.CLASS_NAME = '인간관계론' ;

-- 13 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력
--    CLASS PROFESSOR DEPARTMENT


SELECT      D.DEPARTMENT_NAME     AS "학과 이름"
        ,   C.CLASS_NAME          AS "과목 이름"
FROM        TB_CLASS            C
FULL JOIN   TB_CLASS_PROFESSOR  CP ON(C.CLASS_NO = CP.CLASS_NO)
FULL JOIN   TB_PROFESSOR        P  ON(CP.PROFESSOR_NO = P.PROFESSOR_NO) 
FULL JOIN   TB_DEPARTMENT       D  ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO)
WHERE       D.CATEGORY = '예체능' AND CP.PROFESSOR_NO IS NULL
ORDER BY 1;

SELECT      D.DEPARTMENT_NAME
        ,   C.CLASS_NAME
FROM        TB_DEPARTMENT       D 
JOIN        TB_CLASS            C  ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO)
LEFT JOIN   TB_CLASS_PROFESSOR  CP ON(C.CLASS_NO = CP.CLASS_NO)
WHERE       CATEGORY = '예체능' AND PROFESSOR_NO IS NULL
ORDER BY 1 , 2;

-- ERD를 자세히 보고 부모 자식 관계를 확인할 것

/* 14 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 핚다. 학생이름과
지도교수 이름을 찾고 맊일 지도 교수가 없는 학생일 경우 "지도교수 미지정‛으로
표시하도록 하는 SQL 문을 작성하시오. 단, 출력헤더는 ‚학생이름‛, ‚지도교수‛로
표시하며 고학번 학생이 먼저 표시되도록 한다. */


SELECT      S.STUDENT_NAME                                          AS "학생 이름"
        ,   NVL(P.PROFESSOR_NAME , '지도 교수 미지정')                AS "지도 교수"
FROM        TB_STUDENT      S
JOIN        TB_DEPARTMENT   D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO) 
LEFT JOIN   TB_PROFESSOR    P ON(P.PROFESSOR_NO = S.COACH_PROFESSOR_NO) 
WHERE       D.DEPARTMENT_NAME = '서반아어학과' 
ORDER BY    STUDENT_NO DESC ;

