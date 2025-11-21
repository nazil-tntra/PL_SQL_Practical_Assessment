DECLARE
   v_department EMPLOYEE.DEPARTMENT%TYPE := '&Enter_Department_Name';

   CURSOR emp_cur
    IS
        SELECT EMP_ID, EMP_NAME, SALARY, JOINING_DATE
        FROM EMPLOYEE
        WHERE DEPARTMENT = v_department;


    emp_row EMPLOYEE%ROWTYPE;

BEGIN


    OPEN emp_cur;

    LOOP
        FETCH emp_cur INTO 
            emp_row.emp_id,
            emp_row.emp_name,
            emp_row.salary,
            emp_row.joining_date;

        EXIT WHEN emp_cur%NOTFOUND;

        PRINT_EMPLOYEE_ROW(emp_row);

    END LOOP;

 
END;
/


SELECT * FROM EMPLOYEE;
