class Product
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :length, type: String
  field :width, type: String
  field :height, type: String
  field :weight, type: String
end
