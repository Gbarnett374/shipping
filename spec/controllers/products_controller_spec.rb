require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:valid_attributes) {
    {
      name: 'Small Bag', 
      type: 'Golf', 
      length: 22, 
      width: 2, 
      height: 5, 
      weight: 25
    }
  }

  let(:invalid_attributes) {
    {
      name: 22, 
      type: 'Golf', 
      length: 'test', 
      width: 2, 
      height: 5, 
      weight: 25
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      product = Product.create! valid_attributes
      get :show, params: {id: product.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, params: {product: valid_attributes}
        }.to change(Product, :count).by(1)
      end

      it "renders a JSON response with the new product" do

        post :create, params: {product: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(product_url(Product.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new product" do

        post :create, params: {product: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { 
          name: 'Small Bag', 
          type: 'Golf', 
          length: 2, 
          width: 2, 
          height: 5, 
          weight: 50
        }
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        put :update, params: {id: product.to_param, product: new_attributes}
        product.reload

        expect(product.weight).to eq(50)
        expect(product.length).to eq(2)
      end

      it "renders a JSON response with the product" do
        product = Product.create! valid_attributes

        put :update, params: {id: product.to_param, product: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the product" do
        product = Product.create! valid_attributes

        put :update, params: {id: product.to_param, product: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete :destroy, params: {id: product.to_param}
      }.to change(Product, :count).by(-1)
    end
  end

end
