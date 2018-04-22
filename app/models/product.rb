class Product
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  validates :name, format: { with: /[a-zA-Z]+/ }
  validates :type, format: { with: /[a-zA-Z]+/ }
  validates :length, numericality: { only_integer: true }
  validates :width, numericality: { only_integer: true }
  validates :height, numericality: { only_integer: true }
  validates :weight, numericality: { only_integer: true }
end
