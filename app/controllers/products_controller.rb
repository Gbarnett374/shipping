class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products.json
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1.json
  def show
    render json: @product
  end

  # POST /products.json
   # http POST localhost:3000/products.json product:='{"width":20, "height": 20, "weight": 20, "length": 20, "name": "Greg", "type": "golf"}'
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1.json
  def update
    if @product.update(product_params)
      render json: @person
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1.json
  def destroy
    @product.destroy
  end

  private
    
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
  end
end
