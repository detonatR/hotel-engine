Thank you for taking the time to review my submission. I tried to find a good balance between simple and over-engineering to address the task.

Each scope of work is broken down into separate git commits.

# Acceptance Criteria

1. Review ratings are integers and have validations for presence and numericality for 1-5 range
2. Description has no presence validation
3. Handled through a validation using the private number_of_reviews method on Review. User authentication handled using Devise Token Auth
4. Tried to make the errors as descriptive as I can. However, structure of the returned JSON highly dependent on business requirements (just an array of full messages, or by attribute etc)
5. Review is a nested resource under the books endpoint. Filtering and Sorting are done through the Filterable and Sortable concerns

# Stretch Goals

1. ProfanityValidator with blacklist in profanity.en.yml locale
2. Review model is polymorphic, with reviewable concern and route concern
3. Done using an after save callback on Review. However, normally I would do a rake task + background job

# Dependencies

1. Ruby 2.7.3
2. Bundler 2.2.9
3. Rails 6.1.3
4. Postgres
5. Git

# Installation

1. `bundle install`
2. `rake db:setup`

# Running the Specs
`rails spec` or `rspec spec`

# Start the Server
`rails s`
