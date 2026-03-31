SELECT *
FROM telco;

-----overall churn rate---------
SELECT
     COUNT ( CASE WHEN Churn_Label = 'Yes' THEN 1 END) * 100.0 / COUNT (*) AS Churn_rate
FROM telco;

------contract type with highest churn-----
SELECT [Contract],
      COUNT(*) AS Total_customers,
	  SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned_customers
FROM telco
GROUP BY [Contract]
ORDER BY Churned_customers;

----------Average monthly charge by internet service---
SELECT Internet_service,
       AVG(Monthly_charge) AS avg_monthly_charge
FROM telco
GROUP BY Internet_service;

--Customers with high life time revenue---
SELECT Customer_ID,
       Tenure_in_Months,
	   Monthly_charge,
	   Total_charges
FROM telco
ORDER BY Total_charges DESC;

-----do senior citizens churn more
SELECT Senior_Citizen,
		COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned
FROM telco
GROUP BY Senior_Citizen;

SELECT Under_30,
		COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned_under30
FROM telco
GROUP BY Under_30;

----common services among churned customers
SELECT Internet_Service,
	   Online_Security,
	   Premium_Tech_Support,
	   COUNT(*) AS Churned_customers
FROM telco
WHERE Churn_Label = 'Yes'
GROUP BY Internet_Service, Online_Security, Premium_Tech_Support
ORDER BY Churned_customers DESC;

-----tech support--

SELECT Premium_Tech_Support,
       COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned
FROM telco
GROUP BY Premium_Tech_Support
ORDER BY Churned DESC;

------ internet services---
SELECT Internet_Service,
       COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned
FROM telco
GROUP BY Internet_Service
ORDER BY Churned DESC;

----internet type
SELECT Internet_Type,
       COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned
FROM telco
GROUP BY Internet_Type
ORDER BY Churned DESC;

-----Gender----
SELECT Gender,
       COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned
FROM telco
GROUP BY Gender
ORDER BY Churned DESC;

------online security----
SELECT Online_Security,
       COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned
FROM telco
GROUP BY Online_Security
ORDER BY Churned DESC;

-----Tenure's effect on churn---
----SELECT CASE
      --   WHEN Tenure_in_Months < 12 THEN 'New_customers'
	   --  WHEN Tenure_in_Months BETWEEN 12 AND 36 THEN 'Mid_customer'
	   --  ELSE 'Long_term'
	   ---END AS Tenure_group,
	   --COUNT(*) AS Total,
	   --SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned
--FROM telco
--GROUP BY Tenure_group;

SELECT 
    CASE 
        WHEN Tenure_in_Months < 12 THEN 'New Customers'
        WHEN Tenure_in_Months BETWEEN 12 AND 36 THEN 'Mid-term'
        ELSE 'Long-term'
    END AS tenure_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn_Label  = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM telco
GROUP BY 
    CASE 
        WHEN Tenure_in_Months < 12 THEN 'New Customers'
        WHEN Tenure_in_Months BETWEEN 12 AND 36 THEN 'Mid-term'
        ELSE 'Long-term'
    END;

-----add column----
ALTER TABLE telco
ADD tenure_group VARCHAR(50);

UPDATE telco
SET tenure_group =
    CASE 
        WHEN Tenure_in_Months < 12 THEN 'New Customers'
        WHEN Tenure_in_Months BETWEEN 12 AND 36 THEN 'Mid-term'
        ELSE 'Long-term'
    END;

-----cities with high revenue
SELECT City, SUM( Total_Charges) AS Total_revenue
FROM telco
GROUP BY City
ORDER BY Total_revenue DESC;


-------payment method with higher churn----
SELECT Payment_Method,
		COUNT (*) AS Total_Customers,
		SUM( CASE WHEN Churn_Label = 'Yes' THEN 1  ELSE 0 END) AS Churned
FROM telco
GROUP BY Payment_Method
ORDER BY Churned DESC;

SELECT City, Latitude, Longitude
FROM telco
WHERE [State] = 'California'