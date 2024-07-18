-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- Create main tables
CREATE TABLE "patients" (
    "id" INTEGER,
    "first_name" TEXT,
    "last_name" TEXT,
    "gender" TEXT CHECK ("gender" IN("M", "F")),
    "age" TEXT,
    PRIMARY KEY ("id")
);

CREATE TABLE "parameters" (
    "patient_id" INT,
    "body_temperature" TEXT,
    "pulse_rate" TEXT,
    "blood_pressure" TEXT,
    "respiration_rate" TEXT,
    "date" DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "symptoms"(
    "patient_id" INT,
    "yellow_fingers" TEXT CHECK("yellow_fingers" IN("0", "1")),
    "fatigue" TEXT CHECK("fatigue" IN("0", "1")),
    "allergy" TEXT CHECK("allergy" IN("0", "1")),
    "wheezing" TEXT CHECK("wheezing" IN("0", "1")),
    "coughing" TEXT CHECK("coughing" IN("0", "1")),
    "hemoptysis" TEXT CHECK("hemoptysis" IN("0", "1")),
    "shortness_of_breath" TEXT CHECK("shortness_of_breath" IN("0", "1")),
    "swallowing_difficulty" TEXT CHECK("swallowing_difficulty" IN("0", "1")),
    "chest_pain" TEXT CHECK("chest_pain" IN("0", "1")),
    "anxiety" TEXT CHECK("anxiety" IN("0", "1")),
    "depression" TEXT CHECK("depression" IN("0", "1")),
    "weight_loss" TEXT CHECK("weight_loss" IN("0", "1")),
    "date" DEFAULT CURRENT_TIMESTAMP
    FOREIGN KEY("patient_id") REFERENCES "patients"("id")
);

CREATE TABLE "jobs" (
    "patient_id" INT,
    "job" TEXT,
    "sector" TEXT,
    "location" TEXT,
    "start_date" DATE,
    "end_date" DATE,
    FOREIGN KEY("patient_id") REFERENCES "patients"("id")
);

CREATE TABLE "relatives"(
    "patient_id" INT,
    "familiar_id" INT,
    "relationship" TEXT CHECK("relationship" IN (
        "father",
        "mother",
        "son",
        "daughter",
        "brother",
        "sister",
        "uncle",
        "aunt",
        "nephew",
        "grandfather",
        "grandmother"),
    FOREIGN KEY("patient_id") REFERENCES "patients"("id")
    FOREIGN KEY("familiar_id") REFERENCES "patients"("id")
);

CREATE TABLE "diseases" (
    "patient_id" INT,
    "cancer" TEXT CHECK("cancer" IN("0", "1"),
    "cancer_type" TEXT,
    "chronic_disease" TEXT,
    "diagnosis_date" DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "lifestyle"(
    "patient_id" INT,
    "smoking" TEXT CHECK("smoking" IN("0", "1"),
    "alcohol" TEXT CHECK("alcohol" IN("0", "1"),
    "diet" TEXT CHECK("diet" IN("0", "1"),
    "kg_lost" TEXT,
    "hobby" TEXT
);

-- Create indexes
CREATE INDEX "person_id" ON "patients"("id");
CREATE INDEX "person_first_name" ON "patients"("first_name");
CREATE INDEX "person_last_name" ON "patients"("last_name");
CREATE INDEX "yellow_fingers" ON "symptoms"("yellow_fingers");
CREATE INDEX "fatigue" ON "symptoms"("fatigue");
CREATE INDEX "allergy" ON "symptoms"("allergy")
CREATE INDEX "wheezing" ON "symptoms"("wheezing");
CREATE INDEX "coughing" ON "symptoms"("coughing");
CREATE INDEX "shortness_of_breath" ON "symptoms"("shortness_of_breath");
CREATE INDEX "swallowing_difficulty" ON "symptoms"("swallowing_difficulty");
CREATE INDEX "chest_pain" ON "symptoms"("chest_pain");
CREATE INDEX "weight_loss" ON "symptoms"("weight_loss");
CREATE INDEX "jobs" ON "jobs"("job");
CREATE INDEX "cancers" ON "diseases"("cancer_type");
CREATE INDEX "smokers" ON "lifestyle"("smoking");

-- Create views
CREATE VIEW "people_with_cancer" AS
SELECT p.*, d.cancer_type
FROM patients AS p
JOIN diseases AS d ON p.id = d.patient_id
WHERE d.cancer = 1;

CREATE VIEW "person_symptoms" AS
SELECT p.*, s.*
FROM patients AS p
JOIN symptoms AS s ON p.id = s.patient_id;

CREATE VIEW "smokers" AS
SELECT p.*
FROM patients AS p
JOIN lifestyle AS l ON p.id = l.patient_id
WHERE l.smoking = 1;
