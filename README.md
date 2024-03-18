
# Loose Tea

Welcome to **Loose Tea**, a straightforward application designed to help you discover, purchase, and subscribe to monthly tea clubs. Whether you're a tea enthusiast or new to the world of tea, Loose Tea offers a seamless experience to explore and enjoy a wide range of teas.

## Key Information

- **Ruby Version**: 3.1.4
- **Rails Version**: 7.1.3.2
- **Database**: PostgreSQL

## How to Run the Test Suite

To ensure the application functions as expected, run the following command in the Terminal while inside the root directory:

```sh
bundle exec rspec
```

## Services

Loose Tea is built with simplicity in mind, featuring essential backend functionalities through models, controllers, and serializers.

## Getting Started

Follow these instructions to get Loose Tea up and running on your local machine:

1. **Clone the Repository**

   Use the following command to clone the repo:

   ```sh
   git clone <repository-url>
   ```

2. **Install Dependencies**

   Navigate to the root directory of the project and run:

   ```sh
   bundle install
   ```

3. **Start the Rails Server**

   Launch the application with:

   ```sh
   rails server
   ```

   Note: Loose Tea requires a front-end for full functionality.

## Practical Use

### Database Schema Visualization

For a detailed view of the database schema, visit the following link:

[DB Diagram for Loose Tea](https://dbdiagram.io/d/LooseTea-659c2bf8ac844320ae79928c)

### API Endpoints

Interact with the Loose Tea API through the following endpoints. The base URL for local development is `http://localhost:3000`.

#### Subscriptions

- **List All Subscriptions for a Customer**
  
  `GET /api/v1/customers/:id/subscriptions`

- **Retrieve a Single Subscription**
  
  `GET /api/v1/customers/:id/subscriptions/:subscription_id`

- **Create a New Subscription**
  
  `POST /api/v1/customers/:id/subscriptions`

- **Update a Subscription**
  
  `PATCH /api/v1/customers/:id/subscriptions/:subscription_id`

- **Delete a Subscription**
  
  `DELETE /api/v1/customers/:id/subscriptions/:subscription_id`

#### Customers

- **List All Customers**
  
  `GET /api/v1/customers`

- **Retrieve One Customer by ID**
  
  `GET /api/v1/customers/:id`

- **Create a New Customer**
  
  `POST /api/v1/customers`
