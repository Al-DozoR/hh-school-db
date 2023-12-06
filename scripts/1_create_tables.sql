-- Удаление Таблиц
drop table IF EXISTS responses;
drop table IF EXISTS vacancies;
drop table IF EXISTS cities;
drop table IF EXISTS areas;
drop table IF EXISTS resumes;
drop table IF EXISTS specialization;

-- Создание таблицы регионов
CREATE TABLE Areas
(
    area_id   SERIAL PRIMARY KEY,
    area_name VARCHAR(100) NOT NULL
);

-- Создание таблицы городов
CREATE TABLE Cities
(
    city_id   SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    area_id INT REFERENCES Areas (area_id) NOT NULL
);

-- Создание таблицы специализаций
CREATE TABLE Specialization
(
    specialization_id SERIAL PRIMARY KEY,
    specialization_name VARCHAR(100) NOT NULL
);

-- Создание таблицы вакансий
CREATE TABLE Vacancies
(
    vacancy_id        SERIAL PRIMARY KEY,
    title             VARCHAR(255) NOT NULL,
    description       TEXT NOT NULL,
    company           VARCHAR(100) NOT NULL,
    city_id           INT REFERENCES Cities (city_id) NOT NULL,
    compensation_from NUMERIC CHECK (compensation_from >= 0 OR compensation_from IS NULL),
    compensation_to   NUMERIC CHECK (compensation_from >= 0 OR compensation_from IS NULL),
    specialization_id INT REFERENCES Specialization (specialization_id) NOT NULL,
    status            VARCHAR(10) NOT NULL CHECK (status IN ('open', 'closed', 'draft')),
    date_posted       TIMESTAMP NOT NULL,
    last_updated      TIMESTAMP NOT NULL
);

-- Создание таблицы резюме
CREATE TABLE Resumes
(
    resume_id         SERIAL PRIMARY KEY,
    full_name         VARCHAR(150) NOT NULL,
    age               INT CHECK ((age >= 0 AND age <= 100) OR age IS NULL),
    gender            VARCHAR(10) NOT NULL CHECK (gender IN ('male', 'female')),
    email             VARCHAR(100) CHECK ((email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$') OR email IS NULL),
    phone             VARCHAR(20) NOT NULL,
    experience        TEXT,
    education         TEXT,
    skills            TEXT,
    specialization_id INT REFERENCES Specialization (specialization_id) NOT NULL,
    date_created      TIMESTAMP NOT NULL,
    last_updated      TIMESTAMP NOT NULL
);

-- Создание таблицы откликов
CREATE TABLE Responses
(
    response_id   SERIAL PRIMARY KEY,
    vacancy_id    INT REFERENCES Vacancies (vacancy_id) NOT NULL,
    resume_id     INT REFERENCES Resumes (resume_id) NOT NULL,
    status        VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'responded', 'rejected', 'accepted')),
    response_date TIMESTAMP NOT NULL,
    last_updated  TIMESTAMP NOT NULL
);