
-- check if there is unmatched data
SELECT count(*) FROM features f
left join Sales s 
on f.Store =s.Store 
where s.store is null
;

SELECT * FROM  Sales s 
left join features f 
on f.Store =s.Store 
where f.store is null
;

-- stores that have no sales
select * from Stores st
left join Sales sa 
on st.Store  = sa.Store 
where sa.store is null
;

-- count 421570
SELECT count(*) FROM features f
 join Sales s 
on f.Store =s.Store 
and s.Date =f.Date 
--where s.store is null
;

-- how many stores are there 
select distinct Store from Stores
;


-- main

select Store, DATE, Weekly_Sales ,
sum(weekly_Sales) over(partition by Store) total_sale,
lag(weekly_Sales) over(partition by Store order by DATE) sales_last_week,
sum_last_4w,
min_last_4w,
max_last_4w,
strftime('%m', date) AS num_Month,
(sum(MarkDown1) over(partition by Store) / sum(weekly_Sales) over(partition by Store) ) * 100 as percentM1,
(sum(MarkDown2) over(partition by Store) / sum(weekly_Sales) over(partition by Store) ) * 100 as percentM2,
(sum(MarkDown3) over(partition by Store) / sum(weekly_Sales) over(partition by Store) ) * 100 as percentM3,
(sum(MarkDown4) over(partition by Store) / sum(weekly_Sales) over(partition by Store) ) * 100 as percentM4,
(sum(MarkDown5) over(partition by Store) / sum(weekly_Sales) over(partition by Store) ) * 100 as percentM5
FROM
(
SELECT 
ST.Store,  
SA.DATE,
sum(sa.Weekly_Sales) Weekly_Sales,
sum(f.MarkDown1) MarkDown1,
sum(f.MarkDown2) MarkDown2,
sum(f.MarkDown3) MarkDown3,
sum(f.MarkDown4) MarkDown4,
sum(f.MarkDown5) MarkDown5,
case when sa.date >= datetime(sa.date,'-28 days','localtime') then sum(weekly_Sales)  else null END sum_last_4w,
case when sa.date >= datetime(sa.date,'-28 days','localtime') then min(weekly_Sales)  else null END min_last_4w,
case when sa.date >= datetime(sa.date,'-28 days','localtime') then max(weekly_Sales)  else null END max_last_4w
from Stores st
join Sales sa 
on st.Store  = sa.Store 
join Features f 
on f.Store = st.Store 
and f.Date  = sa.Date 
where st.store = 1
group by st.Store , sa.Date 
) a
ORDER BY DATE DESC
;

