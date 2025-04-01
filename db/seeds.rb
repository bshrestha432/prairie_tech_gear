# db/seeds.rb
puts "Seeding database..."

# Clear existing data only in development
if Rails.env.development?
  puts "Clearing existing data..."
  [OrderItem, Order, Payment, Review, Product, Category, User, AdminUser].each do |model|
    model.destroy_all
  end
  puts "Database cleared"

end

# Create admin user safely
admin = AdminUser.find_or_initialize_by(email: 'admin@example.com')
if admin.new_record?
  admin.password = 'password'
  admin.password_confirmation = 'password'
  admin.save!
  puts "Created admin user: admin@example.com"
else
  puts "Admin user already exists: admin@example.com"
end

# db/seeds.rb (additive version)
categories = ["Electronics", "Clothing", "Home & Garden", "Sports Equipment"]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

puts "Current category count: #{Category.count}"



# Create products
puts "Creating products..."
100.times do |i|
  product_name = "Product #{i+1} - #{Faker::Commerce.product_name}"

  product = Product.create_with(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 50..2000),
    stock_quantity: rand(1..100),
    category_id: Category.pluck(:id).sample
  ).find_or_create_by!(name: product_name)

  # Uncomment to attach images if you have placeholder.png in assets
  # unless product.images.attached?
  #   product.images.attach(
  #     io: File.open(Rails.root.join('app/assets/images/placeholder.png')),
  #     filename: 'placeholder.png'
  #   )
  # end
end
puts "Created #{Product.count} products"

# Create regular users with unique emails
puts "Creating users..."
25.times do |n|
  email = "user#{n+1}@example.com"  # Ensures unique emails
  user = User.find_or_initialize_by(email: email)
  if user.new_record?
    user.assign_attributes(
      name: Faker::Name.name,
      password: 'password',
      role: 'customer'
    )
    user.save!
    puts "Created user: #{email}"
  else
    puts "User already exists: #{email}"
  end
end

puts "Seeding completed successfully!"