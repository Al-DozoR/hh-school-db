--Запрос для получение id и title вакансий, которые собрали больше 5 откликов в первую неделю размещения
SELECT
    v.vacancy_id AS vacancy_id,
    v.title AS title
FROM Vacancies v
INNER JOIN Responses r ON r.vacancy_id = v.vacancy_id
WHERE r.response_date <= v.date_posted + INTERVAL '1 week'
GROUP BY v.vacancy_id, v.title
HAVING COUNT(r.vacancy_id) > 5
ORDER BY vacancy_id;
