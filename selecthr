-- Pull matching data for acting / perm roles only

SELECT DISTINCT 
    id_number, 
    given_name, 
    family_name, 
    emp_job_entity, 
    position_type_indicator, 
    emp_job_site_number, 
    emp_job_activity, 
    emp_job_main_account, 
    emp_job_sub_account 
FROM 
    sum_hr_emp_pos_costings_vw c
WHERE 
    effective_date_job = (
        SELECT 
           MAX(effective_date_job) 
           FROM 
              sum_hr_emp_pos_costings_vw c1 
           WHERE 
               c.id_number = c1.id_number 
           AND c1.effective_date_job <= GETDATE()
    )
AND (position_type_indicator = 'P' OR position_type_indicator = 'A')
