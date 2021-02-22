--from sample DB, checking budgets above or below $100,000.
SELECT   project_name, budget, "Budget Range" =   
      CASE   
         WHEN budget < 100000 THEN 'Under $100k'  
         WHEN budget >= 100000 THEN 'Over $100k'  
      END  
FROM project
ORDER BY project_name;  

