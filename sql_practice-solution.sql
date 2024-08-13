/*Easy*/

/*1)Show first name, last name, and gender of patients whose gender is 'M'*/
select first_name, last_name, gender from patients
where gender= 'M';

/*2)Show first name and last name of patients who does not have allergies. (null) */
select first_name, last_name from patients
where allergies is Null;

/*3)Show first name of patients that start with the letter 'C' */
select first_name from patients 
where first_name like 'C%';

/*4) Show first name and last name of patients that weight within the range of 100 to 120 (inclusive) */
select first_name, last_name from patients
where weight between 100 and 120;

/*5)Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA' */
update patients
set allergies ='NKA'
where allergies is null;

/*6)Show first name and last name concatinated into one column to show their full name.*/
select concat(first_name, ' ', last_name) as full_name from patients;

/*7)Show first name, last name, and the full province name of each patient.
Example: 'Ontario' instead of 'ON' */
select p.first_name, p.last_name, pn.province_name from patients as p
join province_names as pn
on p.province_id=pn.province_id;

/*8)Show how many patients have a birth_date with 2010 as the birth year. */
select count(*) as birth_date1 from patients
where year(birth_date)= 2010;

/*or*/
select count(first_name)as total_birth from patients
where birth_date >= '2010-01-01'
and birth_date<= '2010-12-31';

/*9)Show the first_name, last_name, and height of the patient with the greatest height.*/
select first_name, last_name, max(height) from patients
where max(height);

/*or*/
select first_name, last_name, height from patients
where height=(
  select max(height) from patients
);

/*10)Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000 */
select * from patients
where patient_id in (1, 45, 534, 879, 1000)
  /*OR*/
  select * from patients
where patient_id= 1
or patient_id=45
or patient_id=534
or patient_id=879
or patient_id=1000

/*11)Show the total number of admissions */
  select count(*)as total_admission  from admissions

  /*12)Show all the columns from admissions where the patient was admitted and discharged on the same day. */
  select * from admissions
where admission_date == discharge_date;

/*13)Show the patient id and the total number of admissions for patient_id 579. */
select patient_id,count(*)as total_count from admissions
where patient_id= 579;

/*14)Based on the cities that our patients live in, show unique cities that are in province_id 'NS'? */
select distinct(city)as unique_city from patients
where province_id='NS';

/*OR*/
select city from patients
group by city
having province_id= 'NS';

/*15)Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70 */
select first_name, last_name, birth_date from patients
where height>160 and weight>70;

/*16)Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton' */
select first_name, last_name, allergies from patients
where allergies not null and city= 'Hamilton';

/*Medium*/

/*17)Show unique birth years from patients and order them by ascending. */
select year(birth_date)years from patients
group by year(birth_date) /*Another way to remove duplicates in SQL is by using the GROUP BY clause */

/*OR*/
select distinct year(birth_date)years from patients
order by birth_date asc;

/*/OR Sub query method*/
select distinct(years) from
(
  select year(birth_date)as years from patients
  order by birth_date asc
 )
patients

/*18)Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output. */
select first_name from patients
group by first_name
having count(first_name)=1

  /*19)Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.*/
  select province_id,sum(height) as total_heights from patients
group by province_id
having total_heights>=7000

  /*OR sub query method*/
  select * from(select province_id, sum(height)as sum_heights from patients
group by province_id)where sum_heights>=7000;

/*20)Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' */
select (max(weight) - min(weight)) as difference_weight from patients
where last_name ='Maroni'

  /*OR*/
  select largest_weight - smallest_weight as difference_weight from 
(select max(weight)as largest_weight , min(weight) as smallest_weight from patients
where last_name='Maroni') patients








  

/* We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane */

select concat(upper(last_name),',',lower(first_name))as new_name_format from patients
order by first_name desc;
