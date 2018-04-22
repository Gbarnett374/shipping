require 'json'
products_file = File.read('products.json')
products_hash = JSON.parse(products_file).first[1]
products_hash.each { |h| @product = Product.new(h).save }
puts "#{Product.count} records created!"