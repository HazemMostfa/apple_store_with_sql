-- combining all the data in one table

create table appleStore_description AS
SELECT * FROM appleStore_description1 
UNION all 
SELECT * FROM appleStore_description2
UNION all 
SELECT * FROM appleStore_description3
UNION all 
SELECT * FROM appleStore_description4

-- check the number of unique apps in both tableapplestore

SELECT COUNT(DISTINCT id ) as count FROM AppleStore

SELECT COUNT(DISTINCT id ) as count FROM appleStore_description

-- check for any missing value in key fields


SELECT COUNT(*) FROM appleStore_description 
WHERE track_name is NULL or size_bytes is null  or app_desc is null


SELECT COUNT(*) FROM AppleStore 
WHERE track_name is NULL or size_bytes is null  or app_desc is null

-- find out the number of apps per ganer

SELECT prime_genre ,count(*) as num_apps
FROM AppleStore
GROUP by prime_genre
ORDER by num_apps

-- get an overview of the apps ratings

SELECT 	min(user_rating) as min_rating,
   		max(user_rating) as max_rating ,
  		avg(user_rating) as avg_rating 
 FROM AppleStore

-- determine wether paid apps have higher tatings then free apps

SELECT 
case when price = 0 then 'free' else 'paid' end as statues
,avg(user_rating) as avg_ratings
FROM AppleStore
GROUP by statues

-- check if apps with more languages have higher ratings

SELECT CASe WHen lang_num <10 THEN '10 < lags'
when lang_num BETWEEN 10 AND 20 then '10 < langs > 20'
when lang_num >20 THEN '20 > langs'
else null END as num_lang_statues,
round(avg(user_rating),2) as avg_ratings
FROM AppleStore
GROUP by num_lang_statues
ORDER by avg_ratings desc

-- CHECK the ganer with the lower ratings

SELECT prime_genre,avg(user_rating) as avg_ratings 
FROM AppleStore 
GROUP by prime_genre
order by avg_ratings 
LIMIT 1

-- check if there is a coralation between app desc lenth and the ratings

SELECT case when length(d.app_desc)<500 then 'short'
			when length(d.app_desc) BETWEEN 500 and 1000 then 'medium'
            else 'long' end as length_statues 
            ,round(avg(a.user_rating),4) as avg_ratings
from appleStore_description  as d 
join AppleStore as a 
USING(id)
GROUP by length_statues 
order by avg_ratings

-- check the top rated apps for each ganre
SELECT * FROM (
select prime_genre,user_rating,rank() over(partition by prime_genre order by user_rating desc,rating_count_tot desc) as rank
FROM AppleStore
) as s where s .rank=1

















