# Shipping 
- Built using Ruby 2.4.1, Rails 5.16, and MongoDB 3.6.4.
## Getting Started
1. Make sure MongoDB is installed and running. 
2. Run `bundle install`. 
3. Seed the database run `rails r scripts/seed.rb`.
4. Start the Server: `rails s`.
5. To run tests: `rspec`.
6. To view the admin dashboard go to `localhost:3000/admin`.
7. To view the calculator go to `localhost:3000/calculator`.

## API Endpoints 
- Here are all the API endpoints with example CURL commands. 
* `# GET /products.json => ProductsController#index`
    * `CURL localhost:3000/products`
* `# GET /products/:id.json => ProductsController#show`
    * `CURL localhost:3000/products/5add19e63108592d4dced32b.json`
* `# GET /products/:length/:width/:height/:weight.json => ProductsController#search` 
    * `CURL localhost:3000/products/22/2/22/22.json`
* `# POST /products.json => ProductsController#create`
    * `CURL -X POST localhost:3000/products.json -d "product[name]=suitcase" -d "product[type]=luggage" -d "product[length]=22" -d "product[width]=4" -d "product[height]=7" -d "product[weight]=22"` 
* `# PATCH/PUT /products/:id.json => ProductsController#update`
    * `CURL -X PATCH localhost:3000/products/5ade4ce331085928d5bda177.json -d "product[name]=suitcase" -d "product[type]=luggage" -d "product[length]=22" -d "product[width]=4" -d "product[height]=7" -d "product[weight]=29"`
* `# DELETE /products/:id.json => ProductController#destory`
    * `CURL -X DELETE localhost:3000/products/5ade4ce331085928d5bda177.json`