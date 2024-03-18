# README

***Hello and welcome to Loose Tea. This is a simple app that can help you find teas, purchase teas or subscribe to monthly tea clubs.***

### Things to know:

* Ruby version - 3.1.4

* Rails version - 7.1.3.2

* Database - PostgreSQL

* How to run the test suite - run 'bundle exec rspec' with Terminal inside the root directory.

* Services - Very simple: model, controller - serializer backend features. 

* Instructions - Clone repo, run 'bundle install' and then 'rails server' to run. 
Needs front-end for full functionality. 

# Practical Use
### Link to DB Diagram for schema visualization:
https://dbdiagram.io/d/Loose-Tea-659c2bf8ac844320ae79928c

### Endpoints for consumption:

- Base Url: http://localhost:3000


#### <--- Subscriptions --->

Get a list of all subscriptions for a customer:
- GET /api/v1/customers/:id/subscriptions

Get a single subscription for a customer:
- GET /api/v1/customers/:id/subscriptions/:subscription_id

Create a new subscription for a customer:
- POST /api/v1/customers/:id/subscriptions

Change a customer's subscription:
- UPDATE /api/v1/customers/:id/subscriptions/:subscription_id

Delete a subscription for a customer:
- DELETE /api/v1/customers/:id/subscriptions/:subscription_id

#### <--- Customers --->

Get a list of all customers: 
- GET /api/v1/customers

Get one customer by ID:
- GET /api/v1/customers/:id

Create a new customer:
- POST /api/v1/customers

