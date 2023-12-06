--Запрос на получение месяца с наибольшим количеством вакансий
SELECT
    to_char(date_posted, 'YYYY-MM') AS год_месяц,
    COUNT(*) AS "кол-во вакансий"
FROM Vacancies
GROUP BY "год_месяц"
ORDER BY "кол-во вакансий" DESC LIMIT 1;

--Запрос на получение месяца с наибольшим количеством резюме
SELECT
    to_char(date_created, 'YYYY-MM') AS год_месяц,
    COUNT(*) AS "кол-во резюме"
FROM Resumes
GROUP BY "год_месяц"
ORDER BY "кол-во резюме" DESC LIMIT 1;
