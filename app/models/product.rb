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

  def self.find_correct_container(l,w,h,lbs)
    # Product.any_of({:length.gte => params[:length]}, {:height.gte => params[:length]})
    # @products = Product.where(:length.gte => params[:length]).where(:width.gte => params[:width])
    self.where(:weight.gte => lbs).order_by('weight asc, length asc').each do |product|
      if product.length >= l && product.width >= w && product.height >= h 
        return product
      elsif product.length >= h && product.width >= w && product.height >= l 
        # rotate item and see if it will fit in the box. 
        return product
      end
    end
    nil
  end
end
