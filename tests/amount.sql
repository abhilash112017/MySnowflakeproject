select
    id,
    Count(*) as duplicate_count
from {{ ref('orders' )}}
group by id
having count(*) > 0