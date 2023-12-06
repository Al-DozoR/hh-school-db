-- Удаление Таблиц
drop table IF EXISTS responses;
drop table IF EXISTS vacancies;
drop table IF EXISTS cities;
drop table IF EXISTS areas;
drop table IF EXISTS resumes;
drop table IF EXISTS specialization;
DROP TYPE IF EXISTS vacancies_status;
DROP TYPE IF EXISTS gender;
DROP TYPE IF EXISTS responses_status;

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
CREATE TYPE vacancies_status AS ENUM ('open', 'closed', 'draft');
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
    status            vacancies_status NOT NULL,
    date_posted       TIMESTAMP NOT NULL,
    last_updated      TIMESTAMP NOT NULL
);

-- Создание таблицы резюме
CREATE TYPE gender AS ENUM ('male', 'female');
CREATE TABLE Resumes
(
    resume_id         SERIAL PRIMARY KEY,
    full_name         VARCHAR(150) NOT NULL,
    age               INT CHECK ((age >= 0 AND age <= 100) OR age IS NULL),
    gender            gender NOT NULL,
    email             VARCHAR(100) NOT NULL,
    phone             VARCHAR(20) NOT NULL,
    experience        TEXT,
    education         TEXT,
    skills            TEXT,
    specialization_id INT REFERENCES Specialization (specialization_id) NOT NULL,
    date_created      TIMESTAMP NOT NULL,
    last_updated      TIMESTAMP NOT NULL
);

-- Создание таблицы откликов
CREATE TYPE responses_status AS ENUM ('pending', 'responded', 'rejected', 'accepted');
CREATE TABLE Responses
(
    response_id   SERIAL PRIMARY KEY,
    vacancy_id    INT REFERENCES Vacancies (vacancy_id) NOT NULL,
    resume_id     INT REFERENCES Resumes (resume_id) NOT NULL,
    status        responses_status NOT NULL,
    response_date TIMESTAMP NOT NULL,
    last_updated  TIMESTAMP NOT NULL
);
