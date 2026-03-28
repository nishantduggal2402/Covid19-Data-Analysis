# Data Cleaning for table coviddeaths4
alter table coviddeaths4 
modify column date date;
update coviddeaths4
set population = null
where population = '';
alter table coviddeaths4
modify column population bigint;

# converting blank strings to null for coviddeaths4 table
update coviddeaths4
set total_cases = nullif(total_cases, ''), new_cases = nullif(new_cases, ''), 
new_cases_smoothed = nullif(new_cases_smoothed, ''), total_deaths = nullif(total_deaths, ''),
new_deaths = nullif(new_deaths, ''), new_deaths_smoothed = nullif(new_deaths_smoothed,''),
total_cases_per_million = nullif(total_cases_per_million, ''), new_cases_per_million = nullif(new_cases_per_million , ''),
new_cases_smoothed_per_million = nullif(new_cases_smoothed_per_million, ''), total_deaths_per_million = nullif(total_deaths_per_million,''),
new_deaths_per_million = nullif(new_deaths_per_million, ''), new_deaths_smoothed_per_million = nullif(new_deaths_smoothed_per_million, ''),
reproduction_rate = nullif(reproduction_rate, ''), icu_patients = nullif(icu_patients, ''),
icu_patients_per_million = nullif(icu_patients_per_million, ''), hosp_patients = nullif(hosp_patients, ''),
hosp_patients_per_million = nullif(hosp_patients_per_million, ''), weekly_icu_admissions = nullif(weekly_icu_admissions, ''),
weekly_icu_admissions_per_million = nullif(weekly_icu_admissions_per_million, ''), weekly_hosp_admissions = nullif(weekly_hosp_admissions, ''),
weekly_hosp_admissions_per_million = nullif(weekly_hosp_admissions_per_million, '');

# converting required columns of table coviddeaths4 to datatype double 
alter table coviddeaths4
modify column total_cases double, modify column new_cases double, modify column new_cases_smoothed double,
modify column total_deaths double , modify column new_deaths double, modify column new_deaths_smoothed double,
modify column total_cases_per_million double, modify column new_cases_per_million double,
modify column new_cases_smoothed_per_million double, modify column total_deaths_per_million double,
modify column new_deaths_per_million double, modify column new_deaths_smoothed_per_million double,
modify column reproduction_rate double, modify column icu_patients double,
modify column icu_patients_per_million double, modify column hosp_patients double,
modify column hosp_patients_per_million double, modify column weekly_icu_admissions double,
modify column weekly_icu_admissions_per_million  double, modify column weekly_hosp_admissions double,
modify column weekly_hosp_admissions_per_million double;
describe coviddeaths4;

# Data Cleaning for table coviddeaths4
alter table covidvaccinations4
modify column date date;

# converting blank strings to null for covidvaccinations4 table
update covidvaccinations4
set new_tests = nullif(new_tests, ''), total_tests = nullif(total_tests, ''), 
total_tests_per_thousand = nullif(total_tests_per_thousand, ''), new_tests_per_thousand = nullif(new_tests_per_thousand, ''),
new_tests_smoothed = nullif(new_tests_smoothed, ''), new_tests_smoothed_per_thousand = nullif(new_tests_smoothed_per_thousand,''),
positive_rate = nullif(positive_rate, ''), tests_per_case = nullif(tests_per_case , ''),
tests_units = nullif(tests_units, ''), total_vaccinations = nullif(total_vaccinations,''),
people_vaccinated = nullif(people_vaccinated, ''), people_fully_vaccinated = nullif(people_fully_vaccinated, ''),
new_vaccinations = nullif(new_vaccinations, ''), new_vaccinations_smoothed = nullif(new_vaccinations_smoothed, ''),
total_vaccinations_per_hundred = nullif(total_vaccinations_per_hundred, ''), people_vaccinated_per_hundred = nullif(people_vaccinated_per_hundred, ''),
people_fully_vaccinated_per_hundred= nullif(people_fully_vaccinated_per_hundred, ''), new_vaccinations_smoothed_per_million = nullif(new_vaccinations_smoothed_per_million, ''),
stringency_index = nullif(stringency_index, ''), population_density = nullif(population_density, ''),
median_age = nullif(median_age, ''), aged_65_older = nullif(aged_65_older, ''), aged_70_older = nullif(aged_70_older, ''),
gdp_per_capita = nullif(gdp_per_capita, ''), extreme_poverty = nullif(extreme_poverty, ''),
cardiovasc_death_rate = nullif(cardiovasc_death_rate, ''), diabetes_prevalence = nullif(diabetes_prevalence,''),
female_smokers = nullif(female_smokers, ''), male_smokers = nullif(male_smokers,''),
handwashing_facilities = nullif(handwashing_facilities,''), hospital_beds_per_thousand = nullif(hospital_beds_per_thousand,''),
life_expectancy = nullif(life_expectancy,''), human_development_index = nullif(human_development_index,'');

# converting required columns of table coviddeaths4 to datatype double 
alter table covidvaccinations4
modify column new_tests double, modify column total_tests double, modify column total_tests_per_thousand double,
modify column new_tests_per_thousand double , modify column new_tests_smoothed double, modify column new_tests_smoothed_per_thousand double,
modify column positive_rate double, modify column tests_per_case double, modify column total_vaccinations double,
modify column people_vaccinated double, modify column people_fully_vaccinated double,
modify column new_vaccinations double, modify column new_vaccinations_smoothed double,
modify column total_vaccinations_per_hundred double, modify column people_vaccinated_per_hundred double,
modify column people_fully_vaccinated_per_hundred double, modify column new_vaccinations_smoothed_per_million double,
modify column stringency_index  double, modify column population_density double,
modify column median_age double, modify column aged_65_older double, modify column aged_70_older double,
modify column gdp_per_capita double, modify column extreme_poverty double,
modify column cardiovasc_death_rate double, modify column diabetes_prevalence double,
modify column female_smokers double, modify column male_smokers double,
modify column handwashing_facilities double, modify column hospital_beds_per_thousand double,
modify column life_expectancy double, modify column human_development_index double;
describe covidvaccinations4;

# EDA
select location, date, total_cases, new_cases, total_deaths, population
from coviddeaths4
order by 1,2;

# Total cases vs Total deaths Analysis and finding Death Percentage shows likelihood 
# of dying if you get infected from covid in particular country
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths4
order by 1,2;

# Total cases vs Population indicating what percentage of people got infected from covid
select location, date, total_cases, population, (total_cases/population) *100 as population_infected
from coviddeaths4
order by 1,2;

# countries with highest Infection rate compared to population
select location, population, max(total_cases) as highest_infection_count,
max((total_cases/population)*100) as percent_population_infected
from coviddeaths4
group by location, population
order by  percent_population_infected desc;

# countries with highest death count per population
select location, max(cast(total_deaths as signed)) as TotalDeathCount
from coviddeaths4
group by location
order by TotalDeathCount desc;

# countries with highest death count per population
select continent, max(cast(total_deaths as signed)) as TotalDeathCount
from coviddeaths4
where continent is not null
group by continent
order by TotalDeathCount desc;

# Global Numbers each day
select date, sum(new_cases) as new_cases_today, sum(cast(new_deaths as signed)) as new_deaths_today ,
 sum(cast(new_deaths as signed))/sum(new_cases) * 100 as New_death_prct
from coviddeaths4
where continent is not null
group by date
order by 1;

# Global numbers across world
select sum(new_cases) as tot_cases, sum(cast(new_deaths as signed)) as tot_deaths ,
sum(cast(new_deaths as signed))/sum(new_cases) * 100 as tot_death_prct
from coviddeaths4
where continent is not null
order by 1;

# Total population vs vaccinations
with cte as (select dhs.continent, dhs.location, dhs.date, dhs.population, vac.new_vaccinations,
sum(cast(vac.new_vaccinations as signed)) over (partition by dhs.location order by dhs.location, dhs.date) as rolling_people_vaccinated
from coviddeaths4 as dhs
join covidvaccinations4 as vac
on dhs.location = vac.location
and dhs.date = vac.date
where dhs.continent is not null)
select *, (rolling_people_vaccinated/population)*100 as vac_percentage
from cte;

# country wise vaccination percentage rate (based on total doses)
with cte as (select dhs.continent, dhs.location, dhs.date, dhs.population, vac.total_vaccinations
from coviddeaths4 as dhs
join covidvaccinations4 as vac 
on dhs.location = vac.location
and dhs.date = vac.date
where dhs.continent is not null),
cte2 as(select continent, location, population, max(total_vaccinations) as max_total_vaccined
from cte 
group by continent, location, population)
select continent, location, population, max_total_vaccined, (max_total_vaccined/population)*100 as vaccination_percentage
from cte2
order by vaccination_percentage desc;















