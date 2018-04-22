require 'pry'
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
  # http get localhost:3000/products/22/22/22/22.json
  # GET /products/:length/:width/:height/:weight.json
  def search
    searchable_fields = ['length', 'width', 'height', 'weight' ]
    @search_values = params.select { |k| searchable_fields.include?(k) }.values.map(&:to_i)
    @product = Product.find_correct_container(*@search_values)
    
    if @product.nil?
      render json: '', status: :not_found
    else
      render json: @product
    end
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
