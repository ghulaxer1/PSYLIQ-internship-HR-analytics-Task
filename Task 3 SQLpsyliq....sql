use diabetes_prediction;

select *from diabetes_prediction;
describe diabetes_prediction;

---- Retrieve the Patient_id and ages of all patients//
select patient_id,age
from diabetes_prediction;

---- Select all female patients who are older than 40 //
select patient_id, gender
 from diabetes_prediction
 where gender= 'Female'
 and age > 40;
 
 ---- Calculate the average BMI of patients//
 select avg(bmi) as average_bmi
 from diabetes_prediction;
 
---- List patients in descending order of blood glucose levels //
 select *from diabetes_prediction
 order by blood_glucose_level
 DESC;
 
---- Find patients who have hypertension and diabetes //
  SELECT * FROM diabetes_prediction 
 WHERE hypertension AND diabetes ;
  
---- Determine the number of patients with heart disease //
SELECT COUNT(*) AS number_of_patients_with_heart_disease 
FROM diabetes_prediction
WHERE heart_disease = 1;
 
---- Group patients by smoking history and count how many smokers and non-smokers there are //
  SELECT smoking_history, 
COUNT(*) AS number_of_patients
FROM diabetes_prediction
GROUP BY smoking_history;

---- Retrieve the Patient_ids of patients who have a BMI greater than the average BMI  //
 SELECT Patient_id
FROM diabetes_prediction
WHERE bmi > (SELECT AVG(bmi) 
FROM diabetes_prediction);

---- Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel //
SELECT *FROM diabetes_prediction
where HbA1c_level = (SELECT max(HbA1c_level) FROM diabetes_prediction);
SELECT *FROM diabetes_prediction
where HbA1c_level = (SELECT MIN(HbA1c_level) FROM diabetes_prediction);

---- Calculate the age of patients in years (assuming the current date as of now) //
SELECT Patient_id, EmployeeName,
Year(now())-age AS Birth_year,
Year(now())-Year(now())+age AS current_age
FROM diabetes_prediction;

---- Rank patients by blood glucose level within each gender group ////
SELECT Patient_id, gender, blood_glucose_level,
RANK() 
OVER (PARTITION BY gender ORDER BY blood_glucose_level DESC) AS
glucose_level_rank
FROM diabetes_prediction;

---- Update the smoking history of patients who are older than 50 to "Ex-smoker."  //
set sql_safe_update=0;
update  diabetes_prediction SET Smoking_History = 'Ex-smoker'
where age > 50;

---- Insert a new patient into the database with sample data. //
 INSERT INTO diabetes_prediction
(EmployeeName, Patient_id, gender, age, hypertension, heart_disease,
smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES
('Mike', 'P1255', 'Male', 35, 0, 0, 'Ex-smoker', 1.1, 1.2, 120, 0);

select*from diabetes_prediction;

---- Delete all patients with heart disease from the database //
SET SQL_SAFE_UPDATES=0;
DELETE FROM diabetes_prediction
WHERE heart_disease = 1;

---- Find patients who have hypertension but not diabetes using the EXCEPT operator //
SELECT *
FROM diabetes_prediction AS t1
WHERE t1.hypertension = 1
  AND NOT EXISTS (
    SELECT 1
    FROM diabetes_prediction AS t2
    WHERE t2.Patient_id = t1.Patient_id
      AND t2.diabetes = 1
  );

----  Define a unique constraint on the "patient_id" column to ensure its values are unique //
ALTER TABLE diabetes_prediction ADD Constraint
UNIQUE_Patient_id unique(Patient_id(20));


---- /Create a view that displays the Patient_ids, ages, and BMI of patients //
CREATE VIEW patient_id AS
SELECT Patient_id, age, bmi
FROM diabetes_prediction ;

----/*Suggest improvements in the database schema to reduce data redundancy and
improve data integrity.....///

To reduce data redundancy and improve data integrity in your database schema, you
can consider the following suggestions:
1.Normalization:
• Apply it to minimize redundancy and dependencies, break down tables into smaller, 
well-structured ones.
• Use keys (PK,FK) and unique constraints to establish relationships between tables.
2. PK and FK:
• Ensure that each table has a PK 
• Use FK to establish relationships between tables
3. Avoid Redundant Columns:
• Avoid storing the same data in multiple tables instead you can make relationships 
between tables.
4. Data Types and Constraints:
• Choose appropriate data type for columns to minimize storage space.
5. Use Transaction:
• To group multiple SQL statements into a single unit of work.
6. Consider Denormalization for Read Performance:
• Denormalization may be considered cautiously to improve query performance, this 
involves duplicating some data to avoid joins.




-----Explain how you can optimize the performance of SQL queries on this dataset ///

Optimizing the performance of SQL queries involves various strategies, and the specific
approach depends on the nature of your dataset, the complexity of your queries, and the
underlying database management system. Here are some general tips to optimize SQL
queries on your dataset: Use Indexing ,Identify columns frequently used in WHERE clauses and JOIN conditions and create indexes
on those columns.


