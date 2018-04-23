require 'json'
initial_count = Product.count
products_file = File.read('products.json')
products_hash = JSON.parse(products_file).first[1]
products_hash.each { |h| Product.new(h).save }
new_records = Product.count - initial_count
puts "Completed #{new_records} added!"