-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- GENERAL DESCRIPTIVE STATISTICS FOR INITIAL INSIGHT OF CORRELATIONS
-- Number of people with cancer
SELECT COUNT(*) FROM people_with_cancer;

-- Number of people with cancer, grouped by gender
SELECT COUNT(*) FROM people_with_cancer
GROUP BY gender;

-- Minimum and maximum age of people with cancer
SELECT MIN(age) AS min_age, MAX(age) AS max_age FROM people_with_cancer
GROUP BY gender;

-- Average age of people with cancer grouped by gender
SELECT *, AVG(age) AS age_average
FROM people_with_cancer
GROUP BY gender
ORDER BY age_average DESC;

-- Number of people having cancer grouped by working sector
-- This might give us an insight of whether a particular sector is more exposed to risk factors for lung cancer
SELECT COUNT(*) AS count_by_sector FROM jobs
WHERE patient_id IN (
    SELECT patient_id
    FROM diseases
    WHERE cancer = 1
)
GROUP BY sector
ORDER BY count_by_sector DESC;
-- This is almost the same query, but returning only the 10 most counted working sectors of people with cancer
SELECT COUNT(*) AS count_by_sector FROM jobs
WHERE patient_id IN (
    SELECT patient_id
    FROM diseases
    WHERE cancer = 1
)
GROUP BY sector
ORDER BY count_by_sector DESC
LIMIT 10;

-- Number of people with cancer grouped by working location
SELECT COUNT(*) AS count_by_working_location FROM jobs
WHERE patient_id IN (
    SELECT patient_id
    FROM diseases
    WHERE cancer = 1
)
GROUP BY location
ORDER BY count_by_location DESC;
-- Same thing as before, but returning only the 100 most reported location of working place of people with cancer
-- Some places might be more exposed to radiation, pollution etc. which are risk factors for cancer
SELECT COUNT(*) AS count_by_location FROM jobs
WHERE patient_id IN (
    SELECT patient_id
    FROM diseases
    WHERE cancer = 1
)
GROUP BY location
ORDER BY count_by_location DESC
LIMIT 100;

-- Amount of smokers with cancer by gender
-- This would be used to check if gender is correlated to the onset and behavior of cancer based on gender and other genetic factors
SELECT COUNT(*) AS count_by_gender FROM smokers
GROUP BY gender
ORDER BY count_by_gender DESC;

-- Inserting credential of new patients
INSERT INTO 'patients'(first_name, last_name, gender, age)
VALUES (examplename, examplelastname, M, 25);

-- Updating info about a patient which was recently diagnosed with cancer
UPDATE 'diseases' SET cancer = 1
WHERE ID = (
    SELECT id FROM patients
    WHERE first_name = examplename AND last_name = examplelastname
);

-- Removing patients who can't be included anymore in the studies
DELETE FROM 'patients'
WHERE first_name = examplename AND last_name = examplelastname
