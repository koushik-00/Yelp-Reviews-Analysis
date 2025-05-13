create or replace table yelp_reviews (review_text variant)

COPY INTO yelp_reviews
FROM 's3://kosu-bucket/yelp_reviews/'
CREDENTIALS = (
    AWS_KEY_ID = '***************'
    AWS_SECRET_KEY = '***************'
)
FILE_FORMAT = (TYPE = JSON);


select * from yelp_reviews limit 10;

create or replace table tbl_yelp_reviews as 
select review_text:business_id::string as business_id
, review_text:user_id::string as user_id
, review_text:date::date as review_date
, review_text:stars::number as review_stars
, review_text:text::string as review_text
, analyze_sentiment(review_text) as sentiments

from yelp_reviews
limit 100



select * from tbl_yelp_reviews limit 10