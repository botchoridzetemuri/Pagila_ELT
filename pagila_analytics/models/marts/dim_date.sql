with date_spine as (
    -- This generates 10,000 rows of dates starting from Jan 1, 2000
    select
        dateadd(day, seq4(), '2000-01-01')::date as date_day
    from table(generator(rowcount => 10000))
),

final as (
    select
        date_day as date_id,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        extract(dayofweek from date_day) as day_of_week,
        extract(quarter from date_day) as quarter,
        case when extract(dayofweek from date_day) in (0, 6) then true else false end as is_weekend
    from date_spine
    -- Pagila data is mostly from 2005 to 2007, so this easily covers it
    where date_day <= '2030-12-31' 
)

select * from final