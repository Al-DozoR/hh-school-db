--Запрос на получение месяца с наибольшим количеством вакансий
SELECT
    to_char(date_posted, 'Month') AS месяц,
    COUNT(*) AS "кол-во вакансий"
FROM Vacancies
GROUP BY "месяц"
ORDER BY "кол-во вакансий" DESC LIMIT 1;

--Запрос на получение месяца с наибольшим количеством резюме
SELECT
    to_char(date_created, 'Month') AS месяц,
    COUNT(*) AS "кол-во резюме"
FROM Resumes
GROUP BY "месяц"
ORDER BY "кол-во резюме" DESC LIMIT 1;