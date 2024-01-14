class PurchaseAddress
  include ActiveModel::Model
  
  attr_accessor :user_id, :item, :post_code, :prefecture_id, :city, :town_number, :building_name, :telephone_number

  with_options presence: true do
    validates :user_id
    validates :item
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :town_number
    validates :telephone_number, numericality: { only_integer: true, greater_than_or_equal_to: 10_000_000_00, less_than: 10_000_000_000 }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }



  def save
    purchase = Purchase.create(user_id: user_id, item: item)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, town_number: town_number, building_name: building_name, telephone_number: telephone_number, purchase_id: purchase.id)
  end
end