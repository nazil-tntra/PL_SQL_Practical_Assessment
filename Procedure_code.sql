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