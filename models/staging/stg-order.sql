{{ config(materialized= 'ephemeral')}}

WITH tb1 as(
    select id,
    user_id,order_date, status
     

    from {{source('datafeed_shared_schema','raw_orders')}})
select * from tb1