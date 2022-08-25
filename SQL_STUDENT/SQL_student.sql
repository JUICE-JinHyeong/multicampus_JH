/*
SQL(Strurcture Query Languange)

세미콜론은 구문을 닫을때만 사용

검색 - SELECT
구문형식
1. SELECT * |(또는) COLUMN_NAME | EXPRESSION
2. FROM     TABLE_NAME
3. WHERE    SEARCH_CONDITION

수정 - UPDATE 
삭제 - DELETE
생성 - INSERT
*/
SELECT *
FROM    EMPLOYEE;

SELECT *
FROM    JOB;

SELECT *
FROM SAL_GRADE;

SELECT SLEVEL
FROM SAL_GRADE;

SELECT SLEVEL AS "급여등급",
       LOWEST,
       HIGHEST
FROM SAL_GRADE;

SELECT *
FROM    EMPLOYEE
WHERE   MARRIAGE = 'N';

SELECT *
FROM    department ;

SELECT *
FROM    EMPLOYEE ;

SELECT *
FROM    LOCATION ;

SELECT *
FROM    COUNTRY ;

SELECT *
FROM    JOB ;

SELECT *
FROM    SAL_GRADE ;

-- 컬럼에 대한 연사 표현식
-- 연봉 확인?
SELECT EMP_NAME ,
       SALARY   ,
       SALARY * 12 AS "연봉" , -- AS는 별칭이다.
       (SALARY + (SALARY * BONUS_PCT)) * 12 AS "보너스" --문자열에 특수기호가 존재할 경우 "" 로 묶어야한다.
FROM EMPLOYEE ;

-- 220819 --

-- 중복값을 한 번씩만 출력 DISTINCT
-- SELECT절에 DISTINCT 는 한 번만 사용 가능

SELECT  DISTINCT JOB_ID, DEPT_ID
FROM    EMPLOYEE;


-- 리터럴 ''(싱글 코테이션)

SELECT  EMP_ID ,
        EMP_NAME ,
        '재직' AS "근무여부"
FROM    EMPLOYEE ;

-- WHERE : 행에 대한 제한

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = '90';

-- 급여가 500만 이상인 사원만 출력

SELECT  *
FROM    EMPLOYEE
WHERE   SALARY >= 5000000; -- 칼럼의 데이터가 문자열인지 숫자인지 확인할 것

-- 부서코드가 90이고 급여를 200만 보다 많이 받는 사원의 이름, 부서 코드. 급여 조회

SELECT  DEPT_ID AS "부서 코드" ,
        EMP_NAME AS "사원 이름" ,
        SALARY AS "급여"
FROM    EMPLOYEE
WHERE   SALARY > 2000000 AND DEPT_ID = '90';

-- 연산자  ||(컬럼과 컬럼을 연결한 경우)
SELECT  EMP_NAME||'의 급여는 '||SALARY||'(원) 입니다.' AS "INFO" -- 연결 연산자
FROM    EMPLOYEE;

-- 논리연산자(TRUE / FALSE / NULL)
-- AND, OR, NOT
-- = , > , < , >= , <= , != , <> , ^=
-- BETWEEN AND , LIKE , NOT LIKE , IS NULL , IS NOT NULL , IN

-- 급여를 350만 이상 550만 이하인 사원의 이름과 급여 조회
-- 조건과 결과를 잘 구분할 것
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY >= 3500000 AND SALARY <= 5500000;

SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   SALARY BETWEEN 3500000 AND 5500000;

SELECT *
FROM EMPLOYEE ;

-- 김씨 성을 가진 사원의 이름과 급여 조회
-- LIKE 연산자를 이용한 패턴 검색 %(0개 이상의 문자) , _ (문자 1개를 의미)
SELECT  EMP_NAME,
        SALARY
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE '김%';

-- 9000번대 4자리 국번의 전화번호를 사용하는 사원의 전화번호를 조회

SELECT  EMP_NAME,
        PHONE
FROM    EMPLOYEE
WHERE   PHONE LIKE '___9%' ;
        
-- NULL 여부를 비교하는 연산자
SELECT  *
FROM    EMPLOYEE ;

-- 보너스를 받지 않는 사원의 모든 정보를 조회
-- IS NULL

SELECT  *
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NULL;

-- 60q번 부서나 90번 부서원들의 이름, 부서 코드, 급여를 조회


SELECT  EMP_NAME,
        DEPT_ID,
        SALARY
FROM    EMPLOYEE
WHERE   DEPT_ID = '60' or DEPT_ID = '90' ;


SELECT  EMP_NAME,
        DEPT_ID,
        SALARY
FROM    EMPLOYEE
WHERE   DEPT_ID IN ( '60' , '90') ;


-- 연산자 우선 순위


SELECT  EMP_NAME,
        SALARY,
        DEPT_ID
FROM    EMPLOYEE
WHERE   (DEPT_ID IN( '20' , '90')) AND SALARY > 3000000;

-- 연산자 우선 순위는 존재하나 () 소괄호로 구분지어버리면 외우지 않아도 괜찮다.


-- 1

SELECT  DEPARTMENT_NAME AS "학과 명",
        CATEGORY AS "계열"
FROM    TB_DEPARTMENT ;


-- 2

SELECT  DEPARTMENT_NAME||'의 정원은 '||CAPACITY||'명 입니다.'
FROM    TB_DEPARTMENT ;
        
 
-- 3

SELECT  DEPARTMENT_NAME,
        DEPARTMENT_NO
FROM    TB_DEPARTMENT
WHERE   DEPARTMENT_NAME LIKE '국어%' ;

SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   ABSENCE_YN = 'Y' AND DEPARTMENT_NO = '001' AND STUDENT_SSN LIKE '%-2%';


-- 4


SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   STUDENT_NO IN ( 'A513079', 'A513090', 'A513091', 'A513110', 'A513119');


-- 5

SELECT  DEPARTMENT_NAME,
        CATEGORY
FROM    TB_DEPARTMENT
WHERE   CAPACITY BETWEEN 20 AND 30;


-- 6

SELECT  PROFESSOR_NAME
FROM    TB_PROFESSOR
WHERE   DEPARTMENT_NO IS NULL;

-- 7


SELECT  STUDENT_NAME
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO IS NULL;


-- 8

SELECT  CLASS_NO
FROM    TB_CLASS
WHERE   PREATTENDING_CLASS_NO IS NOT NULL;


-- 9

SELECT  DISTINCT CATEGORY
FROM    TB_DEPARTMENT ;

-- 10

SELECT  STUDENT_NO,
        STUDENT_NAME,
        STUDENT_SSN
FROM    TB_STUDENT
WHERE   STUDENT_ADDRESS LIKE '전주%' AND ABSENCE_YN = 'N' AND ( ENTRANCE_DATE LIKE '02/%/%' );





/* 

함수 : 문자, 숫자, 날짜
종류 : 단일행, 그룹

어디에 함수를 사용할 것이냐?
- SELECT, WHERE
FROM은 TABLE이 들어가기 때문에 사용 불가.

문자열 함수
 1. LENGTH(): 문자열 길이를 반환
 2. INSTR(): 찾는 문자열이 지정한 위치부터 지정한 횟수만큼 나타난 시작 위치를 반환
    (index string)
 3. LPAD() , RPAD() : 문자열의 공백을 지정한 문자로 덧붙여 반환하는 함수 
 4. SUBSTR(문자열 , 방향 , 길이) : 문자열에서 지정한 위치부터 지정한 갯수만큼 잘라내서 반환
 5. ROUND (숫자 , 표시할 소수점) : 자릿수에서 반올림
 6. TRUNC () : 자릿수에서 내림
 7. SYSDATE : 오늘 날짜 반환
 8. ADD_MONTHS(날짜 , +-할 숫자) : 달 계산
 9. MONTHS_BETWEEN(날짜 , 날짜) : 특정 날짜 사이의 개월 수
*/

-- LENGTH()

SELECT  EMAIL,
        LENGTH(EMAIL)
FROM    EMPLOYEE ;

-- INSTR(문자열, 찾는 문자, 위치, 반복 횟수) 

SELECT  EMAIL,
        INSTR(EMAIL, 'c') ,
        INSTR(EMAIL, 'c', -1) ,
        INSTR(EMAIL, 'c', -1, 2) ,
        INSTR(EMAIL, 'c', INSTR(EMAIL , '.')-1) -- . 다음 c의 위치 반환
FROM    EMPLOYEE ;


-- LPAD() , RPAD() : 문자열의 공백을 지정한 문자로 덧붙여 반환하는 함수

SELECT  EMAIL ,
        LPAD(EMAIL, 20, '.') ,
        RPAD(EMAIL, 20, '.')
FROM    EMPLOYEE ;

-- LTRIM() , RTRIM(), TRIM() : 문자열의 공백(혹은 특정 문자)을 제거하고 반환하는 함수

SELECT  LENGTH('    TECH') ,
        LTRIM('    TECH') , -- 공백이 지워짐
        LENGTH(LTRIM('    TECH')) -- 공백이 지워진 후, 남은 4글자 길이만 반환
FROM    DUAL ;

SELECT  LTRIM('000123' , '0')
FROM    DUAL ;

SELECT  LTRIM('xxxyyyxzzzTRIM' , 'xyz')
FROM    DUAL ;

SELECT  TRIM('    TECH    ') ,
        LENGTH(TRIM('    TECH    '))
FROM    DUAL ;

-- (중요) SUBSTR(문자열, 방향, 길이) : 문자열에서 지정한 위치부터 지정한 갯수만큼 잘라내서 반환 

SELECT  SUBSTR('THIS IS A TEST' , 6) , -- 6번째 인덱스 부터 문자를 가져옴
        SUBSTR('THIS IS A TEST' , 6 , 2) , -- 6번째 부터 2글자
        SUBSTR('THIS IS A TEST', -4 , 4) -- 뒤에서 4번째까지(앞4글자 빼고) 4글자
FROM    DUAL ;

-- 사원의 이메일 중 아이디만 출력한다

SELECT  SUBSTR(EMAIL , 1 , INSTR(EMAIL,'@')-1) -- @의 위치를 찾고, 위치-1 까지 위치값을 SUBSTR에 넣어 @앞 email을 출력한다.
FROM    EMPLOYEE ;


-- 숫자 함수
-- ROUND () : 자릿수에서 반올림 TRUNC () : 자릿수에서 내림

SELECT  ROUND(125.331, 0) ,
        ROUND(125.531, 1) ,
        ROUND(125.531, -1)
FROM    DUAL ;


SELECT  TRUNC(125.331, 0) ,
        TRUNC(125.531, 1) ,
        TRUNC(125.531, -1)
FROM    DUAL ;

-- 날짜 함수

SELECT  HIRE_DATE ,
        SUBSTR(HIRE_DATE , 1, 2)||'년 '||
        SUBSTR(HIRE_DATE , 4, 2)||'월 '||
        SUBSTR(HIRE_DATE , 7, 2)||'일'
FROM    EMPLOYEE ;

-- SYSDATE : 오늘 날짜 반환
-- ADD_MONTHS(날짜, +-할 숫자) : 달 계산

SELECT  SYSDATE ,
        SYSDATE + 1 ,
        ADD_MONTHS(SYSDATE , 1)
        
FROM    DUAL ;

-- 오늘 날짜를 기준으로 입사한지 20년이 넘는 직원의 근무년 수 조회

SELECT  EMP_NAME ,
        MONTHS_BETWEEN('00/01/01', '99/12/15')
FROM    EMPLOYEE ;

SELECT  EMP_NAME ,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS "근무년수"
FROM    EMPLOYEE 
WHERE   MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 240 ;


SELECT  SYSDATE + (INTERVAL '2' YEAR) ,
        SYSDATE + (INTERVAL '2' MONTH)
FROM    DUAL ;


-- 타입 변환 함수
-- TO_NUMBER() , TO_CHAR() , TO_DATE()

SELECT  *
FROM    EMPLOYEE
WHERE   DEPT_ID = 90; -- 묵시적 형변형 결과 출력

SELECT  TO_CHAR(1234) + '5' ,       -- 문자가 됨 , 문자이므로 '' 사용
        TO_NUMBER('1234') + 5 ,     -- 숫자가 됨 , 숫자이므로 '' 사용 x
        TO_CHAR(SYSDATE, 'MM / DD / YYYY / HH:MI:SS , YEAR , Q ')            
        -- 날짜 포맷 TO_CHAR MM DD YY HH MI SS 등
FROM    DUAL ;


SELECT  HIRE_DATE ,
        TO_CHAR(HIRE_DATE , 'YYYY-MM-DD') --20, 21세기 표현에 오류가 생김
FROM    EMPLOYEE ;

SELECT  SYSDATE ,
        '95/08/19' , -- 문자형 날짜 더미 데이터 추가
        TO_CHAR(TO_DATE('95/08/19' , 'YY/MM/DD') , 'YYYY/MM/DD') AS "DATE", -- 2095년이 되는 오류가 생긴다.
        TO_CHAR(TO_DATE('95/08/19' , 'RR/MM/DD') , 'RRRR/MM/DD') AS "DATE" -- 날짜로 변환이 될 때의 포매이션이 RR로 입력되면 세기 계산이 수월해진다.
FROM    DUAL ;
