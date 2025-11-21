-- Creating a table
CREATE TABLE EMPLOYEE(
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50), 
    salary NUMBER(10,2),
    joining_date DATE,
    department VARCHAR2(50)
)


-- Inserting Values
INSERT ALL 
        INTO EMPLOYEE VALUES (101, 'Ayaan', 45000, TO_DATE('2020-01-15','YYYY-MM-DD'), 'SALES')
        INTO EMPLOYEE VALUES (102, 'Riya', 55000, TO_DATE('2021-03-10','YYYY-MM-DD'), 'SALES')
        INTO EMPLOYEE VALUES (103, 'Kabir', 60000, TO_DATE('2019-08-22','YYYY-MM-DD'), 'IT')
        INTO EMPLOYEE VALUES (104, 'Mehak', 52000, TO_DATE('2020-10-01','YYYY-MM-DD'), 'IT')
        INTO EMPLOYEE VALUES (105, 'Arjun', 48000, TO_DATE('2022-02-18','YYYY-MM-DD'), 'HR')
        INTO EMPLOYEE VALUES (106, 'Sana', 53000, TO_DATE('2021-07-29','YYYY-MM-DD'), 'FINANCE')
        INTO EMPLOYEE VALUES (107, 'Rohan', 47000, TO_DATE('2023-05-12','YYYY-MM-DD'), 'MARKETING')
        INTO EMPLOYEE VALUES (108, 'Fatima', 59000, TO_DATE('2020-11-05','YYYY-MM-DD'), 'SALES')
        INTO EMPLOYEE VALUES (109, 'Dev', 62000, TO_DATE('2018-09-14','YYYY-MM-DD'), 'IT')
        INTO EMPLOYEE VALUES (110, 'Naina', 51000, TO_DATE('2019-12-19','YYYY-MM-DD'), 'FINANCE')
SELECT * FROM DUAL;

COMMIT;



-- Procedure print_employee_row
CREATE OR REPLACE PROCEDURE print_employee_row (p_emp EMPLOYEE%ROWTYPE) 
    IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        p_emp.emp_id || ' - ' ||
        p_emp.emp_name || ' - ' || 
        p_emp.salary || ' - ' ||
        TO_CHAR(p_emp.joining_date, 'DD-MON-YYYY')
    );
END;



-- Function get_total_salary
CREATE OR REPLACE FUNCTION get_total_salary (p_department VARCHAR2) RETURN NUMBER
IS
    v_total NUMBER;
BEGIN

    SELECT NVL(SUM(salary),0)
    INTO v_total
    FROM EMPLOYEE
    WHERE DEPARTMENT = p_department;

    RETURN v_total;

END;



-- Main PL/SQL Block
ACCEPT Department;

DECLARE
   v_department EMPLOYEE.DEPARTMENT%TYPE := '&Department';

   CURSOR emp_cur
    IS
        SELECT *
        FROM EMPLOYEE
        WHERE DEPARTMENT = v_department;


    emp_row emp_cur%ROWTYPE;

    v_count NUMBER := 0;

    e_no_emp_found EXCEPTION;

BEGIN


    OPEN emp_cur;

    LOOP
        FETCH emp_cur INTO emp_row;

        EXIT WHEN emp_cur%NOTFOUND;

        v_count := v_count + 1;
        PRINT_EMPLOYEE_ROW(emp_row);

    END LOOP;

    CLOSE emp_cur;


    IF v_count=0 THEN
        RAISE e_no_emp_found;
    END IF;


    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    DBMS_OUTPUT.PUT_LINE(
        'Total Salary for ' || 
        v_department || ' : ' ||
        GET_TOTAL_SALARY(v_department)
    );


    DBMS_OUTPUT.PUT_LINE('Total Employees: ' || v_count);

EXCEPTION

    WHEN e_no_emp_found THEN
        DBMS_OUTPUT.PUT_LINE('NO EMPLOYEE FOUND IN THIS DEPARTMENT');


    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
 
END;
/
