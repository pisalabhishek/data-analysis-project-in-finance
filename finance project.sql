create database bankloan;
use bankloan;
select *from financial_loan;

-- Total Loan Applications
select count(*) from financial_loan;
select count(id) as total_loan_applications from financial_loan;
describe financial_loan;
-- changing datatype of issue date it was text

SET SQL_SAFE_UPDATES = 1;
UPDATE financial_loan
SET issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y');
ALTER TABLE financial_loan
MODIFY COLUMN issue_date DATE;

-- MTD Loan Applications month vise december loan applications
select count(id) as MTD_total_loan_applications from financial_loan where month(issue_date)=12 and year(issue_date)=2021;

-- PMTD Loan Applications previous month applicatoins
SELECT COUNT(id) AS PMTD_Total_Applications FROM financial_loan
WHERE MONTH(issue_date) = 11 ;

-- total funded application
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan;
--  mtd total funded application
select sum(loan_amount) as mtd_Total_Funded_Amount FROM financial_loan where month(issue_date)=12 and  year(issue_date) =2021;
-- pmtd total funded application
select sum(loan_amount) as pmtd_Total_Funded_Amount FROM financial_loan where month(issue_date)=11 and  year(issue_date) =2021;

-- Total Amount Received
select sum(total_payment) as total_amount_received from financial_loan ;

-- mtd Total Amount Received
select sum(total_payment) as mtd_total_amount_received from financial_loan where month(issue_date)=12 and year(issue_date)=2021 ;

-- pmtd Total Amount Received
select sum(total_payment) as ptd_total_amount_received from financial_loan where month(issue_date)=11 and year(issue_date)=2021 ;

-- average interest rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM financial_loan;

-- MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 12 and year(issue_date)=2021;

-- PMTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM financial_loan
WHERE MONTH(issue_date) = 11 and year(issue_date)=2021;

-- avergae debt to income ratio
SELECT AVG(dti)*100 AS Avg_DTI FROM financial_loan;

-- mtd avg dti
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12 and year(issue_date)=2021;

-- pmtd avg dti
SELECT round(AVG(dti),4)*100 AS PMTD_Avg_DTI FROM financial_loan
WHERE MONTH(issue_date) = 11 and year(issue_date)=2021;

-- loan status
 select loan_status from financial_loan;
 
 -- total percentage of good 
 select (count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
/ 
 count(id) as Good_loan_percentage from financial_loan;
 
 -- good loan of application
 select count(id) as Good_loan_Application from financial_loan
 where loan_status = 'Fully Paid' or loan_status ='Current';
 
 -- good loan funded amount 
 
  select sum(loan_amount) as Good_loan_funded from financial_loan
 where loan_status = 'Fully Paid' or loan_status ='Current';
 
 -- total good loan reciveed amount
   select sum(total_payment) as Good_loan_recieved from financial_loan
 where loan_status = 'Fully Paid' or loan_status ='Current';
 
 -- bad loan percentage
 select (count(case when loan_status = 'Charged Off' then id end ) * 100.0)/
 count(id) as bad_loan_percentage from financial_loan;

-- bad loan application
select count(id) as bank_bad_application from financial_loan where loan_status="Charged Off" ;

-- bad loan funded amount

select sum(loan_amount) as bad_loan_funded from financial_loan where loan_status ='Charged Off';

-- bad loan amount recieved

select sum(total_payment) as bad_loan_recieved from financial_loan where loan_status ='Charged Off';

-- loan status analyze
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        financial_loan
    GROUP BY
        loan_status ;
-- loan status
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

--  bank status monthly trend
SELECT 
    MONTH(issue_date) AS Month_Number, 
    MONTHNAME(issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY 
    MONTH(issue_date), 
    MONTHNAME(issue_date)
ORDER BY 
    MONTH(issue_date);
-- state

SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

-- term analysis
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;

-- employyee
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

-- PURPOSE of loan
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY purpose;

-- home owernship
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY home_ownership;

--
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose;


