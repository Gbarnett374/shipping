json.extract! product, :id, :name, :type, :length, :width, :height, :weight, :created_at, :updated_at
json.url product_url(product, format: :json)
