require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'When searching for the best product for a customer' do 
    it 'A Small Package is the best product for these dimensions' do
      length = 48
      width = 14
      height = 12
      weight = 42
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Small Package")
    end
    
    it 'A Large Package is the best product for these dimensions' do
      length = 52
      width = 16
      height = 14
      weight = 56
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Large Package")
    end

    it 'A Extra Large Package is the best product for these dimensions' do
      length = 56
      width = 18
      height = 16
      weight = 70
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Extra Large Package")
    end

    it 'A Carry On is the best product for these dimensions' do
      length = 25
      width = 15
      height = 7
      weight = 25
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Carry On")
    end

    it 'A Oversized Bag is the best product for these dimensions' do
      length = 41
      width = 11
      height = 24
      weight = 72
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Oversized Bag")
    end

    it 'A Ski Bag is the best product for these dimensions' do
      length = 72
      width = 8
      height = 10
      weight = 25
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Ski Bag")
    end

    it 'A Snowboard Bag is the best product for these dimensions' do
      length = 62
      width = 14
      height = 8
      weight = 25
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Snowboard Bag")
    end

    it 'A Double Ski Bag is the best product for these dimensions' do
      length = 80
      width = 10
      height = 12
      weight = 40
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Double Ski Bag")
    end

    it 'A Double Snowboard Bag is the best product for these dimensions' do
      length = 70
      width = 14
      height = 12
      weight = 40
      product = Product.find_correct_container(length, width, height, weight)
      expect(product.name).to eq("Double Snowboard Bag")
    end
  end
  describe 'Before saving products it validates the data' do
    it 'If the name property is not a string, the validation fails' do
      product = Product.create(name: 123, type: 'Golf', length: 22, width: 2, height: 11, weight:25)
      expect(product).to_not be_valid
    end

    it 'If the type property is not a string, the validation fails' do
      product = Product.create(name: 'Large Bag', type: 123, length: 22, width: 2, height: 11, weight:25)
      expect(product).to_not be_valid
    end

    it 'If the length is not an integer, the validation fails' do
      product = Product.create(name: 'Small bag', type: 'Golf', length: 'test', width: 2, height: 11, weight:25)
      expect(product).to_not be_valid
    end

    it 'If the width is not an integer, the validation fails' do
      product = Product.create(name: 'Small bag', type: 'Golf', length: 22, width: 'test', height: 11, weight:25)
      expect(product).to_not be_valid
    end

    it 'If the height is not an integer, the validation fails' do
      product = Product.create(name: 'Small bag', type: 'Golf', length: 22, width: 4, height: 'test', weight:25)
      expect(product).to_not be_valid
    end

    it 'If the weight is not an integer, the validation fails' do
      product = Product.create(name: 'Small bag', type: 'Golf', length: 22, width: 4, height: 22, weight: 'test')
      expect(product).to_not be_valid
    end
  end
end