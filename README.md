# Design Document
## Scope
* What is the purpose of the database?
The purpose of this database is to store data of symptoms reported by people who participated in a survey about lung cancer.
In the future the dataset will be used for statistical studies to see the correlation between smoking and lung cancer and/or other symptoms which can be correlated.
The future project/projects will have the purpose of building a portfolio and, most of all, the purpose of increasing the knowledge and skills in data science.

* Which people, places, things, etc. are included in the scope of the database?
The people included are patients who participated in a survey concerning lung cancer, presumably.
Those who joined the survey are people who had been diagnosed of lung cancer and people who had not been diagnosed of lung cancer.

* Which people, places, things, etc. are *outside* the scope of the database?
Because of the limited amount of people who joined the survey, the sample size is not enough to provide a complete analysis of the population.
So there's the risk of bias. Plus, because the survey only included questions, there's no certainty of the total objectiveness of the data.
The use of medical tests would have been way more objective.

## Functional Requirements
* What should a user be able to do with the database?
A user should be able to execute various exploratory data analysis and test different machine learning models.
The database would just be a prototype of further databases that could be used for statistical analysis concerning healthcare questions.
Examples would be:
    1. Is age a risk factor for lung cancer?
    2. Is gender a factor influencing the risk of lung cancer?
    3. Are there any pathognomic symptoms of lung cancer?
    4. Can minor behavioral disorders be a sign of lung cancer?
    5. How much is smoking correlated to lung cancer?

* What's beyond the scope of what a user should be able to do with the database?
A user might be interested in using the database as examples or even template for further databases.
What's even more interesting about the dataset is the usability for further studies about other diseases.
The simple structure of the database allows to make more use of the model for any other kind of database.

## Representation
### Entities
* Which entities are chosen to be represented in the database?
The entities will be the patients with their respective vital parameters, symptoms, jobs, relatives, diseases and lifestyle.

* What attributes will those entities have?
Each patient has to have some basic data like their respective full name, age, gender.
The presence of eventual symptoms will be verified, along with other present or past diseases.
There will also be some data about lifestyle, like smoking, alcohol usage, diet etc.

* Why did I choose the types I did?
I chose these type of data as risk factors and symptoms, as they would be useful in order to investigate possible factors correlated with lung cancer.

* Why did I choose these constraints?
1. PATIENTS
For the patients table I chose the constraints NOT NULL for the first and last name, because every patient must have credentials.
The gender has to be either male or female, so M will mean male, and F will mean female.
Every patient must also have an age.
2. PARAMETERS
For the vital parameters I only chose DEFAULT CURRENT_TIMESTAMP in order to monitor each patient's vital parameters at a certain hour of the day.
3. SYMPTOMS
Every symptom will be either present or not present, so that explains the constraint ENUM ('0', '1'). So a value of 0 will indicate the absence of that symptom, while the value 1 will indicate the presence of the symptom.
The date needs the restraint DEFAULT CURRENT_TIMESTAMP in order to register the time and day when the symptoms is reported.
4. JOBS
Jobs might be correlated to the onset of cancer, for example in jobs which have a high risk of exposure to smoke, sunlight etc.
Because there's lots of job types, I put no constraint on the job columm, despite the correlation that the job/jobs of each patient might have.
5. RELATIVES
A relative having cancer is a risk factor for the onset of cancer. The closer the relationship between two relatives, the greater the risk. That explains the choice of putting the ENUM restraint in the relationship column.
6. DISEASES
A patient will either have cancer or not, explaining the ENUM constraint for the values 0 and 1 (absence or presence of cancer).
An other thing to track is the date of the diagnosis, as it would be relevant to eventual studies in order to give an accurate prognosis and choose the best treatment according to the patient's condition.
7. LIFESTYLE
Some habits might be correlated to the onset of lung cancer, explaining the choice of the ENUM values 0 and 1 on the column of smoking and alcohol.
Diet might be relevant in case a patient lost a huge amount of weight, even without any diet, as that is a risk factor of any type of cancer.


## Optimizations
* Which optimizations (e.g., indexes, views) did I create? Why?
I created indexes according to what I thought would be the most frequently used columns.
Because the database would be mostly used for statystical analysis and/or model creations, the symptoms would be of course investigated very frequently.
The presence of cancer and other diseases are of course the most essential aspect to investigate. And then, last but not least, the patients' id will be the most frequently used dataset.

## Limitations
* What are the limitations of the design?
1. Not enough general data
Because this database design would be more specific for the investigation on lung cancer, it wouldn't have other data concerning the general health of the patients, like blood pressure, hormon levels, glicemia etc.
2. Images of tests
The database, as it is now, wouldn't store any data of the patients' tests.

* What might the database not be able to represent very well?
As mentioned before, the absence of images doesn't allow the visualization of some tests, This would limit the contextualization of some data, as medical experience would be preferred when investigating imagery.
The absence of other data would also give a limited view of the patient's general health, as there are a lot of known and unknown factors influencing the onset and behavior of cancer.
