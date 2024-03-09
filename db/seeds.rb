43.times do
  Tea.create!(
    title: Faker::Tea.variety,
    description: Faker::Fantasy::Tolkien.poem,
    temperature: Faker::Number.between(from: 165, to: 212),
    brew_time: Faker::Number.between(from: 2, to: 7)
  )
end
