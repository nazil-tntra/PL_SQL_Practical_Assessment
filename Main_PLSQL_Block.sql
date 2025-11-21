DECLARE
   v_department EMPLOYEE.DEPARTMENT%TYPE := '&Department';

   CURSOR emp_cur
    IS
        SELECT EMP_ID, EMP_NAME, SALARY, JOINING_DATE
        FROM EMPLOYEE
        WHERE DEPARTMENT = v_department;


    emp_row EMPLOYEE%ROWTYPE;

    v_count NUMBER := 0;

    e_no_emp_found EXCEPTION;

BEGIN


    OPEN emp_cur;

    LOOP
        FETCH emp_cur INTO 
            emp_row.emp_id,
            emp_row.emp_name,
            emp_row.salary,
            emp_row.joining_date;

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


    DBMS_OUTPUT.PUT_LINE('Total Employees : ' || v_count);

EXCEPTION

    WHEN e_no_emp_found THEN
        DBMS_OUTPUT.PUT_LINE('NO EMPLOYEE FOUND IN THIS DEPARTMENT');


    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
 
END;
/