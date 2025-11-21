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
