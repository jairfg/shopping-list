# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Creating store sections
section_names = ["meat", "dairy", "bakery", "food", "pharmacy"]
section_names.each do |name|
  StoreSection.find_or_create_by!(name:)
end

# Creating 5 products pending purchase
stores = ["The corner", "Fresh and cheap", "The thousand grains"]
products = ["Butter", "Milk 1 LT", "Biscuits", "1 Kg shrimp bag", "Yogurt"]

5.times do
  Product.find_or_create_by!(
    store_name: stores.sample,
    name: products.sample,
    store_section_id: rand(1..5),
    quantity: rand(1..5),
    purchase_date: rand(1..15).days.ago)
end
