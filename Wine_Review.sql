# DROP DATABASE Wine_Reviews;
CREATE DATABASE Wine_Reviews;
USE Wine_Reviews;

CREATE TABLE Wine (
	Wine_ID INT PRIMARY KEY NOT NULL,
    Country VARCHAR(250),
    Price INT,
    Province VARCHAR(250),
	Region_1 VARCHAR(250),
    Region2 VARCHAR(250),
    Variety VARCHAR(250),
    Winery VARCHAR(250)
);
CREATE TABLE Review (
	Review_Number VARCHAR(50) PRIMARY KEY NOT NULL,
    Taster_Name VARCHAR(250),
    Taster_Twitter_Handle VARCHAR(250),
    Title TEXT,
    Points INT,
    Review TEXT,
    Wine_ID INT,
    FOREIGN KEY (Wine_ID)
		REFERENCES Wine (Wine_ID)
);

#List the names of tasters. Show only the distinct values.
select distinct Taster_Name
from Review;

#What is the average price of wine by country? Show the average column as Average_Wine_Price.
select avg(Price) as Average_Wine_Price, Country
from wine
group by Country;
 
#What kinds of wine (variety) are available in Oregon?
select Variety, Province
from wine
where Province ='Oregon';

#Which wine (ID, country, province, and price) has the highest price?
select Wine_ID, Country,Province, Price
from wine
where Price= (select max(Price) from wine);

#How many of the reviews are by the wine taster Michael Schachner? Show the count of reviews as Review_Count.
select Taster_Name, count(Review) as Review_Count
from review
where Taster_Name = 'Michael Schachner';

#List the top three wineries with the highest average review points.
select Winery, avg(Points) as Review_Points
from wine w
inner join review r 
	on w.Wine_ID= r.Wine_ID
group by Winery 
limit 3;

#List the first 5 records in the Wine table.
select * from wine
limit 5;

#What are the title and review for the wine ID of 47?
select Title, Review, Wine_ID
from review
where Wine_ID = 47;

#We know that the title of a review starts with Kirkland Signature 2011 …,  but we do not know the rest of the title. What are the taster’s name and the full title of the review that its title starts with Kirkland Signature 2011?
select Taster_Name, Title
from review
where Title like "Kirkland Signature 2011%";

#In which wineries in the province of California the average price is more than $70? Show the results in descending order by the average price.
select Winery, Province, avg(Price) as avg_price
from wine
where Province = 'California'
group by Winery
having avg_price > 70
order by avg_price desc;