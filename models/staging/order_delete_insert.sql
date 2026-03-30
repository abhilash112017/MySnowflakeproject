{{ config(materialized="incremental",
         unique_key='id',
         incremental_strategy="delete+insert",
         
) }}

select * from {{source('datafeed_shared_schema','raw_orders')}} 

