--Заполням таблицу areas
INSERT INTO areas (area_name)
SELECT 'Area ' || num
FROM generate_series(1, 30) AS num;

--Заполням таблицу cities
WITH city_data AS (
    SELECT
        (FLOOR(RANDOM() * 30) + 1) AS area_id,
        'City ' || num AS city_name
    FROM generate_series(1, 1000) num
)
INSERT INTO cities (city_name, area_id)
SELECT
    city_name,
    area_id
FROM city_data;

--Заполняем таблицу specialization
INSERT INTO specialization (specialization_name)
SELECT 'Specialization ' || num
FROM generate_series(1, 1000) AS num;

--Заполняем таблицу vacancies
INSERT INTO vacancies (title, description, company, city_id, compensation_from, compensation_to, specialization_id, status, date_posted, last_updated)
SELECT
    'Vacancy ' || num,
    'Description ' || num,
    'Company ' || (RANDOM() * 1000 + 1)::INT,
    (FLOOR(RANDOM() * 1000) + 1),
    (RANDOM() * 100000),
    (RANDOM() * 100000 + (RANDOM() * 100000)),
    (FLOOR(RANDOM() * 1000) + 1),
    CASE
        WHEN RANDOM() < 0.3 THEN 'closed'::vacancies_status
        WHEN RANDOM() < 0.6 THEN 'open'::vacancies_status
        ELSE 'draft'::vacancies_status
    END AS status,
    CURRENT_TIMESTAMP - (RANDOM() * 365 * 5 || ' days')::INTERVAL,
    CURRENT_TIMESTAMP
FROM generate_series(1, 10000) AS num;

--Заполняем таблицу resumes
INSERT INTO Resumes (full_name, age, gender, email, phone, experience, education, skills, specialization_id, date_created, last_updated)
SELECT
    'Full Name ' || num,
    (RANDOM() * 99 + 1)::INT,
    CASE
        WHEN RANDOM() < 0.5 THEN'male'::gender
        ELSE 'female'::gender
    END AS gender,
    'email' || num || '@example.com',
    LPAD(num::text, 11, '8800'),
    'Experience ' || (RANDOM() * 20)::INT || ' years',
    'Education ' || (RANDOM() * 5 + 1)::INT,
    'Skills ' || num,
    (FLOOR(RANDOM() * 1000) + 1),
    CURRENT_TIMESTAMP - (RANDOM() * 365 * 5 || ' days')::INTERVAL,
    CURRENT_TIMESTAMP
FROM generate_series(1, 100000) AS num;

--Заполняем таблицу Responses
WITH RandomVacancies AS (
    SELECT
        vacancy_id,
        date_posted + (RANDOM() * INTERVAL '6 week') AS posted
    FROM Vacancies CROSS JOIN generate_series(1, 10) AS num
    ORDER BY RANDOM()
)
INSERT INTO Responses (vacancy_id, resume_id, status, response_date, last_updated)
SELECT
    rv.vacancy_id,
    (FLOOR(RANDOM() * 100000) + 1),
    CASE
        WHEN RANDOM() < 0.25 THEN 'pending'::responses_status
        WHEN RANDOM() < 0.5 THEN 'responded'::responses_status
        WHEN RANDOM() < 0.75 THEN 'rejected'::responses_status
        ELSE 'accepted'::responses_status
    END AS status,
    rv.posted,
    CURRENT_TIMESTAMP
FROM RandomVacancies rv;
