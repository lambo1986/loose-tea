# README

***Hello and welcome to Loose Tea. This is a simple app that can help you find teas, purchase teas or subscribe to monthly tea clubs.***

Things to know:

* Ruby version - 3.1.4

* Rails version - 7.1.3.2

* Database - PostgreSQL

* How to run the test suite - run 'bundle exec rspec' with Terminal inside the root directory.

* Services - Very simple: model, controller - serializer backend features. 

* Instructions - Clone repo, run 'bundle install' and then 'rails server' to run. 
Needs front-end for full functionality. 

Endpoints for consumption:

- Base Url: http://localhost:3000

- GET /api/v1/customers/:id/subscriptions

- GET /api/v1/customers/:id/subscriptions/:subscription_id

- POST /api/v1/customers/subscriptions

- UPDATE /api/v1/customers/:id/subscriptions/:subscription_id

- DELETE /api/v1/customers/:id/subscriptions/:subscription_id



