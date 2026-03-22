WITH tb1 as(
    select
    id,
    firstname,
    lastname
    from {{source('datafeed_shared_schema','raw_customerdata')}})
select * from tb1 