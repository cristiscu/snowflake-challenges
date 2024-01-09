use schema challenge_fake.public;

-- extract semantic categories
select extract_semantic_categories('CUSTOMERS_FAKE');

-- apply semantic categories
call associate_semantic_category_tags('CHALLENGE_FAKE.PUBLIC.CUSTOMERS_FAKE',
  extract_semantic_categories('CHALLENGE_FAKE.PUBLIC.CUSTOMERS_FAKE'));

-- track applied system tags (show all columns w/ tags in the table)
select * from table(
  information_schema.tag_references_all_columns(
    'CHALLENGE_FAKE.PUBLIC.CUSTOMERS_FAKE', 'table'));
