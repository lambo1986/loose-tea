customer1 = Customer.create!(first_name: "John", last_name: "Doe", email: "john.doe@example.com", address: "123 Elm Street")
customer2 = Customer.create!(first_name: "Jane", last_name: "Doe", email: "jane.doe@example.com", address: "456 Oak Avenue")

tea1 = Tea.create!(title: "Earl Grey", description: "A classic blend, with a touch of bergamot oil.", temperature: 195, brew_time: 4)
tea2 = Tea.create!(title: "Peppermint", description: "Refreshing and invigorating, perfect for after meals.", temperature: 180, brew_time: 5)
tea3 = Tea.create!(title: "Chamomile", description: "A soothing herbal tea, ideal for relaxation.", temperature: 212, brew_time: 5)

subscription1 = Subscription.create!(title: "Monthly Tea Box", price: 20.00, status: "active", frequency: "monthly", customer: customer1)
SubscriptionTea.create!(subscription: subscription1, tea: tea1)
SubscriptionTea.create!(subscription: subscription1, tea: tea2)
