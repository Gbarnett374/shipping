require 'json'
products_file = File.read('products.json')
# Read file into hash 
products_hash = JSON.parse(products_file).first[1]

products_hash.each do |h|
  @product = Product.new(h).save
end
puts "#{Product.count} records created!"