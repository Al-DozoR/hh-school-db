-- Создание индекса для быстрого поиска вакансий по городу и специализации
CREATE INDEX idx_vacancies_city_specialization ON Vacancies (city_id, specialization_id);

-- Создание индекса для быстрого поиска открытых вакансий
CREATE INDEX idx_vacancies_status ON Vacancies (status);

-- Создание индека для быстрого поска вакансий по специализации
CREATE INDEX idx_resumes_specialization ON Resumes (specialization_id);

-- Создание индекса для сопоставления между городами и регионами
CREATE INDEX idx_cities_area_id ON Cities (area_id);

-- Создание индекса для быстрого поиска по регионам
CREATE INDEX idx_areas_area_name ON Areas (area_name);

-- Создание индекса для быстрого поиска откликов
CREATE INDEX idx_responses_resume_id ON Responses (resume_id);

-- Создание индекса для быстрого поиска по специализации
CREATE INDEX idx_specialization_name ON Specialization (specialization_name);
