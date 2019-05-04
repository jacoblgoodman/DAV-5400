create database if not exists citibike;
use citibike;
drop table if exists tripdata;

create table if not exists tripdata (
	tripduration int not null,
	starttime datetime not null,
	stoptime datetime not null,
	start_station_id int default 0001,
	start_station_name 	varchar(100) default "?",
    start_station_latitude DECIMAL(11, 8),
    start_station_longitude	DECIMAL(11, 8),
    end_station_id int default 0001,
	end_station_name varchar(100) default "?",
	end_station_latitude DECIMAL(11, 8),
	end_station_longitude DECIMAL(11, 8),
    bikeid int not null,
    usertype varchar(20) not null,
    birth_year SMALLINT not null,
	gender tinyint not null
);
Load data
infile "201801-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
-- enclosed by '"'
ignore 1 lines;

Load data
infile "201802-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201803-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201804-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201805-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201806-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201807-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201808-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201809-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201810-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201811-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

Load data
infile "201812-citibike-tripdata.csv"
into table citibike.tripdata
fields terminated by ","
enclosed by '"'
ignore 1 lines;

-- sanity check 
select count(*) from citibike.tripdata;

Create index tripdata_starttime
on citibike.tripdata (starttime);

create index tripdata_tripduration
on citibike.tripdata (tripduration);
 
select distinct
	date(starttime) "date", 
    count(bikeid) snum_rides,
    avg(tripduration) avg_tripduration, 
    sum(usertype='subscriber')/count(bikeid) percent_subscriber 
from citibike.tripdata
group by date
;

select distinct  
	date(starttime) "date",
	count(birth_year)
from citibike.tripdata
group by date  
order by starttime desc
;


select * from citibike.tripdata limit 10