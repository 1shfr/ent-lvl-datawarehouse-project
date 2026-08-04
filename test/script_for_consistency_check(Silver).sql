-- before any transformations, we need to indentify the quality issue of the existing raw 
-- this is the special script inorder to check the consistency of the records in schema before heading to another layer

-- checking for the nulls / duplication in primary key
SELECT cst_id, COUNT(*) FROM {schema_name}.crm_cst_info
GROUP BY cst_id HAVING COUNT(*)>1 or cst_id is NULL; 

-- checking for unwanted spaces, expectating no output
SELECT cst_marital_status FROM {schema_name}.crm_cst_info
WHERE cst_marital_status != TRIM(cst_marital_status);

-- checking consistency for the column having low cardinality
SELECT DISTINCT cst_gndr FROM  {schema_name}.crm_cst_info;
SELECT DISTINCT cst_marital_status FROM  {schema_name}.crm_cst_info;

--Checking invalid dates
SELECT COUNT(*) FROM {schema_name}.crm_prd_info
WHERE prd_end_dt < prd_start_dt or prd_start_dt is null

-- checking invalid date
SELECT NULLIF(sls_order_dt,0) as sls_order_dr FROM {schema_name}.crm_sales_details
WHERE sls_order_dt < 0 
OR LEN(sls_order_dt) != 8 
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101
