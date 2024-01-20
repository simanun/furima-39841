class PurchaseAddress
  include ActiveModel::Model

  attr_accessor :token, :user_id, :item_id, :post_code, :prefecture_id, :city, :town_number, :building_name, :telephone_number

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  with_options presence: true do
    validates :city
    validates :town_number
    validates :telephone_number, numericality: { only_integer: true },
                                 format: { with: /\A\d{10,11}\z/, message: 'is too short or too long' }
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Address.create(post_code:, prefecture_id:, city:, town_number:,
                   building_name:, telephone_number:, purchase_id: purchase.id)
  end
end
