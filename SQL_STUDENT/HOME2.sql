-- sql 2주차


-- 주요한 단일행 함수

-- NULL을 지정한 값으로 변환하는 함수 : NVL(), NVL2(A, B, C) - A가 NULL 이 아니라면 B값, NULL이라면 C

SELECT  *
FROM    EMPLOYEE ;


SELECT  EMP_NAME    ,
        SALARY      ,
        NVL(BONUS_PCT , 0) AS "BONUS"
FROM    EMPLOYEE ;


SELECT  EMP_NAME    ,
        SALARY      ,
        SALARY * 12 AS "연봉" ,
        (SALARY + (SALARY * NVL(BONUS_PCT, 1))) * 12 AS "보너스 연봉"
FROM    EMPLOYEE ;

-- DECODE() : IF ~ ELSE 논리를 제한적으로 구현
-- DECODE(EXRP, SEARCH, RESULT, [SEARCH , RESULT] , DEFALUT)
-- 부서번호가 50번호인 사원의 이름, 주민번호, 성별 조회

SELECT  EMP_NAME    ,
        EMP_NO      ,
        DECODE(SUBSTR(EMP_NO , 8 ,1) , '1' , '남자', '2' , '여자', '오류') AS 성별
FROM    EMPLOYEE    
WHERE   DEPT_ID = 50;


SELECT  EMP_ID      ,
        EMP_NAME    
FROM    EMPLOYEE
WHERE   JOB_ID  = 'J4';     -- 테이블 데이터가 대/소 문자인지 구분할 것

SELECT  EMP_ID      ,
        EMP_NAME    ,
        NVL(MGR_ID , '관리자') AS "사수 번호" ,
        DECODE(MGR_ID , NULL , '관리자' , MGR_ID) AS "사수 번호" ,
        DECODE(MGR_ID , NULL , '관리자' , MGR_ID) AS "사수 번호" 
FROM    EMPLOYEE
WHERE   JOB_ID  = 'J4';     

-- 사원들의 직급(JOB_ID)을 확인해서 직급이 J6 이면 급여를 20% 인상 J7 이면 급여를 15% 인상 \
-- 사원이름, 직급, 급여, 인상된 급여를 조회

                
SELECT  EMP_NAME AS "사원 이름" ,
        JOB_ID  AS "직급" ,
        SALARY  AS "본 급여" ,
        DECODE(
        JOB_ID , 
        'J6' , SALARY * 1.2 , 
        'J7' , SALARY * 1.15 , 
        SALARY) AS "인상 급여"
FROM    EMPLOYEE ;


-- CASE (인자가 없다.)
/* 구문 
    CASE EXPR WHEN SEARCH THEN RESULT 
    [WHEN SEATCH THEN RESULT] 
    ELSE DEFAULT END 
*/

-- 주의 CASE 구문 구분은 ','를 사용하지 않는다.
SELECT  EMP_NAME AS "사원 이름" ,
        JOB_ID  AS "직급" ,
        SALARY  AS "본 급여" ,
        CASE    JOB_ID 
                WHEN 'J6' THEN SALARY * 1.2
                WHEN 'J7' THEN SALARY * 1.15
                ELSE SALARY
        END AS "인상 급여"
FROM    EMPLOYEE ;

-- 급여의 등급을 구분

SELECT  EMP_ID      ,
        EMP_NAME    ,
        SALARY      ,
        CASE WHEN SALARY <= 3000000 THEN '초급'
             WHEN SALARY <= 4000000 THEN '중급'
             ELSE '고급' 
        END AS "급여 등급"
FROM    EMPLOYEE ;

-- 그룹함수 (SUM , AVG , MIN , MAX , COUNT)

SELECT  SUM(SALARY)             AS "급여 총합" ,
        TRUNC(AVG(SALARY))      AS "급여 평균" , 
        MIN(SALARY)             AS "최소 급여" ,
        MAX(SALARY)             AS "최대 급여" ,
        COUNT(BONUS_PCT)        AS "보너스 받는 사원 수" , 
        COUNT(*)                AS "사원 수" ,
        MIN(JOB_ID)
FROM    EMPLOYEE ;

-- 그룹을 만들고 만들어진 그룹에 집계를 해야할 경우가 발생
/* GROUP BY절 추가
 GROUP BY 제약이 걸린다.
  1. SELECT 절에 일반컬럼을 사용할 수 없다.
  2. GROUP BY에 명세된 칼럼은 SELECT절에 사용이 가능한다.
  3. 별칭을 그룹의 조건으로 사용할 수 없다.
*/
-- 부서별 급여 평균을 확인하고 싶다면?

SELECT  AVG(SALARY)
FROM    EMPLOYEE
GROUP BY DEPT_ID ;  

-- 성별에 따른 급여 평균

SELECT  TRUNC(AVG(SALARY)) ,
        CASE SUBSTR(EMP_NO , 8 , 1) 
              WHEN '1' THEN '남자'
              WHEN '2' THEN '여자'
              ELSE '오류'
         END 
FROM    EMPLOYEE
GROUP BY CASE SUBSTR(EMP_NO , 8 , 1) 
              WHEN '1' THEN '남자'
              WHEN '2' THEN '여자'
              ELSE '오류'
         END ;
        
        
-- 그룹에 대한 조건을 필요로 한다면?
-- HAVING 절

SELECT  DEPT_ID ,
        SUM(SALARY) 
FROM    EMPLOYEE
GROUP BY DEPT_ID 
HAVING  SUM(SALARY) > 9000000 ; 
-- 그룹이 만들어진 상태에서 WHERE처럼 조건을 주어야할 경우 HAVING을 사용한다.


-- 최소급여를 받는 사원의 이름 급여 직급을 조회한다면?
SELECT  EMP_NAME ,
        SALARY   ,
        JOB_ID
FROM    EMPLOYEE
WHERE   SALARY = (SELECT MIN(SALARY)
                  FROM   EMPLOYEE) ;
                  
                  

-- 정렬

SELECT  *
FROM    EMPLOYEE 
ORDER BY DEPT_ID DESC , HIRE_DATE DESC;


SELECT  EMP_NAME    AS "이름"    ,
        HIRE_DATE   AS "인사일"  ,
        DEPT_ID     AS "부서코드"
FROM    EMPLOYEE 
ORDER BY 3 , "이름" ; -- 칼럼 대신 AS와 INDEX(SELECT에 명시된 칼럼 순서)로 대신 사용 가능하다.


-- 1
SELECT  STUDENT_SSN AS "학번" ,
        STUDENT_NAME AS "이름" ,
        TO_CHAR(TO_DATE(ENTRANCE_DATE , 'RR/MM/DD' ) , 'RRRR/MM/DD') AS "입학년도"
FROM    TB_STUDENT 
WHERE   DEPARTMENT_NO = '002' 
ORDER BY ENTRANCE_DATE ;

-- 2
SELECT  PROFESSOR_NAME ,
        PROFESSOR_SSN
FROM    TB_PROFESSOR 
WHERE   LENGTH(PROFESSOR_NAME) < 3 OR LENGTH(PROFESSOR_NAME) > 3;

-- 3
SELECT  PROFESSOR_NAME AS "교수 이름" ,
        TO_CHAR(SYSDATE , 'YYYY') - LPAD(SUBSTR(PROFESSOR_SSN , 1 , 2) , 4 , '19') AS "나이"
        -- 19||SUBSTR(PROFESSOR_SSN , 1 , 2)
FROM    TB_PROFESSOR 
WHERE   SUBSTR(PROFESSOR_SSN , 8 , 1) = 1
ORDER BY "나이" ;

-- 4

SELECT  SUBSTR(PROFESSOR_NAME , 2 , 2) AS "이름" 
FROM    TB_PROFESSOR ;

-- 5

SELECT  STUDENT_NO ,
        STUDENT_NAME 
FROM    TB_STUDENT 
WHERE   TO_CHAR(TO_DATE(ENTRANCE_DATE , 'RR/MM/DD' ) , 'RRRR') -
        LPAD(SUBSTR(STUDENT_SSN , 1 , 2) , 4 , '19') = 20
ORDER BY STUDENT_NAME ;

-- 6

SELECT  TO_CHAR(TO_DATE('20/12/25' , 'RR/MM/DD') , 'RR/MM/DD(DAY)') AS "크리스마스 요일"
FROM    DUAL ;


-- 7

SELECT  TO_CHAR(TO_DATE('99/10/11' , 'YY/MM/DD'), 'YYYY/MM/DD') AS "1",
        TO_CHAR(TO_DATE('49/10/11' , 'YY/MM/DD'), 'YYYY/MM/DD') AS "2",
        TO_CHAR(TO_DATE('99/10/11' , 'RR/MM/DD'), 'RRRR/MM/DD') AS "3",
        TO_CHAR(TO_DATE('49/10/11' , 'RR/MM/DD'), 'RRRR/MM/DD') AS "4"
FROM    DUAL ;


-- 8

SELECT  STUDENT_NO ,
        STUDENT_NAME
FROM    TB_STUDENT 
WHERE   SUBSTR(STUDENT_NO , 1 , 1) != 'A';


-- 9
SELECT  STUDENT_NO ,
        STUDENT_NAME
FROM    TB_STUDENT 
WHERE   STUDENT_NAME = '한아름' ; 

-- 한아름 A517178

SELECT  ROUND(SUM(POINT) / 8 , 1) AS "평점"
FROM    TB_GRADE 
GROUP BY STUDENT_NO
HAVING STUDENT_NO = 'A517178'
ORDER BY STUDENT_NO ;

-- 10


SELECT  DEPARTMENT_NO AS "학과번호" ,
        COUNT(STUDENT_NAME) AS "학생 수(명)"         
FROM    TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO ;
HAVING  COACH_PROFESSOR_NO = NULL 

-- 11

SELECT  COUNT(*) 
FROM    TB_STUDENT 
GROUP BY COACH_PROFESSOR_NO
HAVING  COACH_PROFESSOR_NO IS NULL ;

-- 12


SELECT  *
FROM    TB_GRADE 
WHERE   STUDENT_NO = 'A112113'
ORDER BY CLASS_NO;

SELECT  STUDENT_NAME ,
        STUDENT_NO 
FROM    TB_STUDENT
WHERE   STUDENT_NAME = '김고운' ;

-- 김고운 A112113

SELECT  LPAD(TERM_NO , 4)               AS "년도" ,
        ROUND(SUM(POINT) / COUNT(POINT) , 1)       AS "학점" -- AVG(POINT)로 대체 가능
FROM    TB_GRADE 
WHERE   STUDENT_NO = 'A112113' 
GROUP BY LPAD(TERM_NO , 4) 
ORDER BY LPAD(TERM_NO , 4);


-- 13 
-- SUM과 COUNT의 차이

SELECT  DEPARTMENT_NO AS "학과코드명",
        SUM(CASE WHEN ABSENCE_YN = 'Y' THEN 1 ELSE 0 END) AS "휴학생 수"   
FROM    TB_STUDENT
GROUP BY DEPARTMENT_NO 
ORDER BY DEPARTMENT_NO ;


-- 14

SELECT  STUDENT_NAME AS "동일 이름" ,
        COUNT(STUDENT_NAME) AS "동명인 수"
FROM    TB_STUDENT
GROUP BY STUDENT_NAME
HAVING  COUNT(STUDENT_NAME) = 2 ;


-- 15 ROLLUP()

SELECT      SUBSTR(TERM_NO , 1 , 4) AS "년도" ,
            SUBSTR(TERM_NO , 5 , 2) AS "학기" ,
            ROUND(AVG(POINT), 1)    AS "평점"
FROM        TB_GRADE
WHERE       STUDENT_NO = 'A112113'
GROUP BY    ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2))
HAVING      ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2)) 
ORDER BY    1 , 2 ;

SELECT      SUBSTR(TERM_NO , 1 , 4) AS "년도" ,
            SUBSTR(TERM_NO , 5 , 2) AS "학기" ,
            ROUND(AVG(POINT), 1)    AS "평점"
FROM        TB_GRADE
WHERE       STUDENT_NO = 'A112113'
GROUP BY    ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2))
HAVING      ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2)) 
ORDER BY    1 , 2 ;




SELECT      SUBSTR(TERM_NO , 1 , 4) AS "년도" ,
            SUBSTR(TERM_NO , 5 , 2) AS "학기" ,
            ROUND(AVG(POINT), 1)    AS "평점"
FROM        TB_GRADE
WHERE       STUDENT_NO = 'A112113'
GROUP BY    ROLLUP(SUBSTR(TERM_NO , 1 , 4) , SUBSTR(TERM_NO , 5 , 2))
;












