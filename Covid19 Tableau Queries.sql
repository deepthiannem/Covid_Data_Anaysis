/*

Queries used for Tableau Visualization

*/


-- 1. 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Projects..CovidDeaths
where continent is not null 
order by 1,2


-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Projects..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- 3.
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount,
       MAX(CONVERT(DECIMAL(20,4), total_cases) / CONVERT(DECIMAL(20,4), population) * 100) AS PercentPopulationInfected
FROM Projects..CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

-- 4.


SELECT 
    Location, 
    Population, 
    date, 
    MAX(total_cases) AS HighestInfectionCount,  
    MAX(CONVERT(DECIMAL(20,10), total_cases) / CONVERT(DECIMAL(20,10), population)) * 100 AS PercentPopulationInfected
FROM 
    Projects..CovidDeaths
GROUP BY 
    Location, 
    Population, 
    date
ORDER BY 
    PercentPopulationInfected DESC
