-- Среднее значение compensation_from
SELECT
    Areas.area_name AS Регион,
   ROUND(AVG(Vacancies.compensation_from), 2) AS "Среднее значение зарплаты, от"
FROM Cities
JOIN Vacancies ON Cities.city_id = Vacancies.city_id
JOIN Areas ON Cities.area_id = Areas.area_id
GROUP BY Areas.area_name;

-- Среднее значение compensation_to
SELECT
    Areas.area_name AS Регион,
    ROUND(AVG(Vacancies.compensation_to), 2) AS "Среднее значение зарплаты, до"
FROM Cities
JOIN Vacancies ON Cities.city_id = Vacancies.city_id
JOIN Areas ON Cities.area_id = Areas.area_id
GROUP BY Areas.area_name;

-- Среднее значение compensation_from и compensation_to
SELECT
    Areas.area_name  AS Регион,
    ROUND(AVG((Vacancies.compensation_from + Vacancies.compensation_to) / 2), 2) AS "Среднее значение зарплаты"
FROM Cities
JOIN Vacancies ON Cities.city_id = Vacancies.city_id
JOIN Areas ON Cities.area_id = Areas.area_id
GROUP BY Areas.area_name;
