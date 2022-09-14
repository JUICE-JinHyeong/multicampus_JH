SELECT  *
FROM    EMPLOYEE ;

SELECT  EMP_NAME
FROM    EMPLOYEE ;

SELECT  EMP_NAME AS "직원"
FROM    EMPLOYEE ; 

SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   MARRIAGE = 'N' ;

SELECT  DISTINCT JOB_ID
FROM    EMPLOYEE ;


SELECT  EMP_NAME    AS "이름"        ,
        SALARY      AS "급여"        ,
        SALARY * 12 AS "연봉"     
FROM    EMPLOYEE ;

SELECT  EMP_NAME AS "이름"        ,
        SALARY AS "급여"          ,
        SALARY * 12 AS "연봉"     ,
        (SALARY + (SALARY * BONUS_PCT)) * 12 AS "보너스"
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NOT NULL ;


-- 급여가 4백만 이상인 사람들을 반환
SELECT  EMP_NAME    ,
        SALARY      
FROM    EMPLOYEE
WHERE   SALARY  >= 4000000 ;


-- 급여가 300만 이상, 5백만 이하인 사람들을 반환
SELECT  EMP_NAME    ,
        SALARY      
FROM    EMPLOYEE
WHERE   SALARY BETWEEN 3000000 AND 5000000 ;

-- 김씨 성을 가진 직원 조회
SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   EMP_NAME LIKE ('김%') ;

-- 9000번대 4자리 국번의 전화번호를 사용하는 사원의 전화번호를 조회
SELECT  EMP_NAME    ,
        PHONE
FROM    EMPLOYEE
WHERE   PHONE LIKE ('___9%') ; -- '_' 가 앞에 3개 연결되어 3글자가 들어온다는 것을 의미
  
  
-- 보너스가 없는 사람들 조회
SELECT  EMP_NAME
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NULL ;


-- 보너스가 있는 사람들의 연봉 및 이름 조회
SELECT  EMP_NAME AS "이름"        ,
        SALARY AS "급여"          ,
        SALARY * 12 AS "연봉"     ,
        (SALARY + (SALARY * BONUS_PCT)) * 12 AS "보너스"
FROM    EMPLOYEE
WHERE   BONUS_PCT IS NOT NULL ;

-- 60번 부서나 90번 부서원들의 이름, 부서코드, 급여를 조회
SELECT  EMP_NAME    ,  
        DEPT_ID     ,
        SALARY
FROM    EMPLOYEE
WHERE   DEPT_ID IN ('60' , '90') ;


-- 함수 LENGTH
SELECT  LENGTH('ABCDEF') 
FROM    DUAL ;

-- 함수 INSTER
SELECT  INSTR('ORANGE GAME' , 'G' , 1,2) AS "INSTR"
-- ORANGE GAME 문자열의 2번째 G 위치를 반환한다.
FROM DUAL ;

-- 함수 LPAD, RPAD(문자열, 공백 수, 공백에 넣을 문자)
SELECT  LPAD('ALPHA', 15, '1234 ') , -- 공백 수에는 문자열의 길이가 포함된다.
        LPAD('ALPHA', 1, '1234 ')  ,
        RPAD('ALPHA', 15, '1234 ')
FROM    DUAL ;

-- 함수 LTRIM, RTRIM, TRIM
SELECT  LTRIM('    ALPHA')      AS "1",     -- 좌측 공백 삭제
        LTRIM('AAAAALPHA', 'A') AS "2",     -- 좌측 A 삭제
        RTRIM('ALPHA    ')      AS "3",     -- 우측 공백 삭제
        RTRIM('ALPHAAAAA', 'A') AS "4",     -- 우측 A 삭제
        TRIM('    ALPHA    ')   AS "5"      -- 양측 공백 삭제
FROM    DUAL ;

-- 함수 SUBSTR
SELECT  SUBSTR('MY NAME IS ALPHA', 1, 7)    AS "1" ,    -- 첫번째 문자열부터 7번째까지 반환 
        SUBSTR('MY NAME IS ALPHA', 4, 4)    AS "2" ,    -- 4번째 문자열부터 4번째까지 반환
        SUBSTR('MY NAME IS ALPHA', -2, 1)   AS "3"      -- 역순으로 2번째 문자열까지 중 첫번째 문자열 반환
FROM    DUAL ;

-- 응용 EMPLOYEE TABLE의 사원들과 사원들의 이메일 @ 앞 부분만 반환
SELECT  EMP_NAME    ,
        EMAIL       ,
        SUBSTR(EMAIL , 1, INSTR(EMAIL, '@') -1)     -- INSTR를 사용하여 @부분의 위치를 반환하고 -1를 해주어 @ 이전 위치를 반환한다.
FROM    EMPLOYEE ;                                  -- 그러므로 SUBSTR의 범위는 1(첫글자)부터 @이전 까지 범위로 지정된 것이다.

-- ROUND
SELECT  ROUND(1.56789, 3)
FROM    DUAL ;

-- TRUNC
SELECT  TRUNC(1.56789, 3)
FROM    DUAL ;

-- SYSDATE
SELECT  SYSDATE
FROM    DUAL ;

-- MONTHS_BETWEEN()
SELECT  MONTHS_BETWEEN(SYSDATE, '2020/12/24') 
FROM    DUAL ;


SELECT  EMP_NAME    AS "사원 이름" ,
        HIRE_DATE   AS "입사 일"   ,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 ) AS "근무년" -- 계산시 년도가 2글자일 경우 연산 과정에서 오류가 발생한다. 20세기와 21세기 차이
FROM    EMPLOYEE ;


SELECT  TO_CHAR(1234) + '5'       AS "1" , -- 문자가 됨 , 문자이므로 '' 사용
        TO_NUMBER('1234') + 5     AS "2" , -- 숫자가 됨 , 숫자이므로 '' 사용 x
        TO_CHAR(SYSDATE, 'MM / DD / YYYY / HH:MI:SS , YEAR , Q ')   AS "3"            
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