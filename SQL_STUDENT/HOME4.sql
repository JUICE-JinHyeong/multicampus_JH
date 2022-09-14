-- SET , SUBQUERY
-- SET  - OPERATER : 두 개 이상의 쿼리 결과를 하나로 결합시키는 연산자
-- UNION , UNION ALL , INTERSECT , MINUS
-- 재약 : SELECT 목록은 반드시 동일 (컬럼 개수, 데이터 타입)

SELECT      EMP_ID
        ,   ROLE_NAME
FROM        EMPLOYEE_ROLE 
MINUS
SELECT      EMP_ID
        ,   ROLE_NAME
FROM        ROLE_HISTORY ;


-- 부서 번호가 20번인 사원의 이름 , 직급 아이디 , 입사일 조회
-- 부서 번호가 20번인 부서 이름 , 부서 아이디 조회


SELECT      E.EMP_NAME
        ,   E.JOB_ID
        ,   HIRE_DATE
FROM        EMPLOYEE E 
WHERE       DEPT_ID = '20' 
UNION
SELECT      D.DEPT_NAME     -- 데이터 타입이 유니온갑 서로 같아야한다. 칼럼의 개수도 같아야한다.
        ,   D.DEPT_ID
        ,   NULL            -- 칼럼의 개수가 동일하지 않아 오류가 나므로 더미 값 NULL을 넣어준다.
FROM        DEPARTMENT D
WHERE       DEPT_ID = '20' ;


-- 50번 부서의 사원 정보로 사원 아이디와 이름 조회

-- UNION 구문을 이용하여 50번 부서의 부서원을 관리자와 직원으로 구분하여 조회하라

SELECT      EMP_ID
        ,   EMP_NAME
        ,   '관리자'
FROM        EMPLOYEE
WHERE       DEPT_ID = '50' AND EMP_ID = '141'
UNION
SELECT      EMP_ID
        ,   EMP_NAME
        ,   '직원'
FROM        EMPLOYEE
WHERE       DEPT_ID = '50' AND EMP_ID != '141' ;


-- 직급이 대리인 사원과 직급이 사원인 사원의 이름 , 직급을 조회

SELECT  *
FROM    JOB ;
SELECT  *
FROM    EMPLOYEE 
ORDER BY JOB_ID;

SELECT      J.JOB_TITLE
        ,   E.EMP_NAME
FROM        JOB J
JOIN        EMPLOYEE E ON (J.JOB_ID = E.JOB_ID)
WHERE       J.JOB_TITLE = '대리' 
UNION
SELECT      J.JOB_TITLE
        ,   E.EMP_NAME
FROM        JOB J
JOIN        EMPLOYEE E ON (J.JOB_ID = E.JOB_ID)
WHERE       J.JOB_TITLE = '사원' ;



-- SRBQUERY : 하나의 쿼리가 다른 쿼리에 포함되는 구조
-- 내부 쿼리, 외부 쿼리
-- 메인쿼리에서 사용할 값을 반환하는 역할
-- SELECT(스칼라) , FROM(인라인) , WHERE(중복) 절 내부에 사용할 수 있다.   


-- 나승원이라는 사원과 같은 부서원


SELECT      EMP_ID
        ,   EMP_NAME
FROM        EMPLOYEE
WHERE       DEPT_ID = ( SELECT DEPT_ID
                        FROM   EMPLOYEE
                        WHERE  EMP_NAME = '나승원');
                        
                        
                        

-- SUBQUERY 유형 ( 단일 행 서브쿼리 , 다중 행 서브쿼리)
-- 유형에 따라서 사용할 수 있는 연산자가 달라진다.
-- 다중 행 서브 쿼리 ( IN , ALL , ANY )



-- 나승원의 직급과 동일하며 나승원보다 많은 급여를 받는 사원 정보

SELECT      EMP_ID
        ,   EMP_NAME
FROM        EMPLOYEE
WHERE       JOB_ID =  ( SELECT JOB_ID
                        FROM   EMPLOYEE
                        WHERE  EMP_NAME = '나승원') 
AND
            SALARY > ( SELECT  SALARY
                        FROM   EMPLOYEE
                        WHERE  EMP_NAME = '나승원');
                        
                        
-- 최소 급여를 받는 사원의 이름, 직급 , 급여

SELECT      E.EMP_NAME
        ,   J.JOB_TITLE
        ,   E.SALARY
FROM        JOB         J 
JOIN        EMPLOYEE    E ON(J.JOB_ID = E.JOB_ID)
WHERE       SALARY = (SELECT MIN(SALARY)
                      FROM   EMPLOYEE) ;
                      
                      

-- 부서별 급여 총합 조회, 부서의 이름 급여 총합 
-- 급여 총합이 가장 높은 부서 출력 

SELECT      D.DEPT_NAME     
        ,   SUM(E.SALARY)
FROM        EMPLOYEE        E
JOIN        JOB             J ON (E.JOB_ID = J.JOB_ID)
JOIN        DEPARTMENT      D ON (E.DEPT_ID = D.DEPT_ID) 
GROUP BY    D.DEPT_NAME ;


SELECT      D.DEPT_NAME     
        ,   SUM(E.SALARY)  -- 이 값에 조건을 준다. 조건  : where , having 그룹이므로 having에 조건
FROM        EMPLOYEE        E
JOIN        JOB             J ON (E.JOB_ID = J.JOB_ID)
JOIN        DEPARTMENT      D ON (E.DEPT_ID = D.DEPT_ID) 
GROUP BY    D.DEPT_NAME 
HAVING      SUM(E.SALARY) = (SELECT MAX(SUM(SALARY))
                             FROM   EMPLOYEE
                             GROUP BY DEPT_ID) ;


-- 부서별 최소급여

SELECT      DEPT_ID
        ,   EMP_NAME
        ,   SALARY
FROM        EMPLOYEE
WHERE      (DEPT_ID , SALARY) IN ( SELECT   DEPT_ID , MIN(SALARY)
                                   FROM     EMPLOYEE
                                   GROUP BY DEPT_ID ) ;


-- 중요
-- ANY
/* ANY < 의미와 > 있을 수 있다. 최댓값보다 작다 , 최솟값보다 크다. 범위 안으로 들어오는 조건*/

-- ALL
/* ALL < 의미와 < 있을 수 있다. 최댓값보다 크다 , 최솟값보다 작다. 범위 밖으로 나가는 조건 */

SELECT      MIN(SALARY)
        ,   DEPT_ID
FROM        EMPLOYEE        
GROUP BY    DEPT_ID ;      


-- 과장 / 대리 직급의 급여 정보를 사원 이름, 급여로 조회

SELECT      *
FROM        JOB ;

SELECT      E.EMP_NAME
        ,   E.SALARY
        ,   J.JOB_TITLE
FROM        EMPLOYEE    E
JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
WHERE       J.JOB_ID = 'J5' ;



SELECT      E.EMP_NAME
        ,   E.SALARY
        ,   J.JOB_TITLE
FROM        EMPLOYEE    E
JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
WHERE       J.JOB_ID = 'J6' ;


-- 과장 직급 보다 많은 급여를 받는 대리 직급의 사원 정보를 조회

SELECT      E.EMP_NAME
        ,   E.SALARY
        ,   J.JOB_TITLE
FROM        EMPLOYEE    E
JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
WHERE       J.JOB_TITLE = '대리'
AND         E.SALARY > ANY (SELECT      SALARY
                            FROM        EMPLOYEE    E
                            JOIN        JOB         J ON(E.JOB_ID = J.JOB_ID)
                            WHERE       J.JOB_TITLE = '과장') ;
                            

-- 자기 직급의 평균 급여를 받는 사원의 이름 , 직급 , 급여를 조회

SELECT      E.EMP_NAME 
        ,   J.JOB_TITLE
        ,   E.SALARY
FROM        JOB     J
JOIN        EMPLOYEE E ON (J.JOB_ID = E.JOB_ID)
WHERE      (J.JOB_ID , E.SALARY) IN (SELECT      JOB_ID
                                             ,   TRUNC(AVG(SALARY) , -5)
                                     FROM        EMPLOYEE
                                     GROUP BY    JOB_ID) ;


SELECT      JOB_ID
        ,   TRUNC(AVG(SALARY) , -5)
FROM        EMPLOYEE
GROUP BY    JOB_ID ;
        
        
        
-- 인라인 FROM 서브쿼리


SELECT      EMP_NAME
        ,   JOB_TITLE
        ,   SALARY
FROM        (   SELECT      JOB_ID
                        ,   TRUNC(AVG(SALARY) , -5) AS JOBAVG
                FROM        EMPLOYEE
                GROUP BY    JOB_ID ) V
JOIN        EMPLOYEE E ON ( V.JOBAVG = E.SALARY AND V.JOB_ID = E.JOB_ID )
JOIN        JOB      J ON ( E.JOB_ID = J.JOB_ID ) ;

-- 상관관계 서브쿼리

SELECT  EMP_NAME,
        JOB_TITLE,
        SALARY
FROM    EMPLOYEE E 
JOIN    JOB      J ON (E.JOB_ID = J.JOB_ID) 
WHERE   SALARY = ( SELECT   TRUNC(AVG(SALARY), -5)
                   FROM     EMPLOYEE
                   WHERE    JOB_ID = E.JOB_ID)   -- 외부 키를 가지고 옴 
ORDER BY E.JOB_ID ;

-- TOP N 분석 : 조건에 맞는 데이터 찾기
-- 가상의 칼럼 : ROWNUM , ROWID

-- 부서별 평균 급여보다 많은 급여를 받는 사원의 이름 , 급여 조회
-- IN-LINE VIEW

SELECT      DEPT_ID
        ,   ROUND(AVG(SALARY) , -3) AS DEPTAVG
FROM        EMPLOYEE
GROUP BY    DEPT_ID ;

-- 

SELECT  ROWNUM,
        EMP_NAME,
        SALARY
FROM    (SELECT  EMP_NAME,
                SALARY
        FROM    (SELECT      DEPT_ID,
                        ROUND(AVG(SALARY), -3) AS DEPTAVG
                 FROM        EMPLOYEE
                 GROUP BY    DEPT_ID) INLV 
        JOIN    EMPLOYEE E ON( E.DEPT_ID = INLV.DEPT_ID) 
        WHERE   SALARY > INLV.DEPTAVG 
        ORDER BY SALARY DESC) 
WHERE   ROWNUM = 1 ;

-- RANK()
SELECT  *
FROM    (SELECT EMP_NAME, 
                SALARY,
                RANK() OVER(ORDER BY SALARY DESC) AS RANK 
        FROM    EMPLOYEE) 
WHERE   RANK = 2 ;
