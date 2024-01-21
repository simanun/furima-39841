class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string     :post_code,        null: false
      t.integer    :prefecture_id,    null: false
      t.string     :city,             null: false
      t.string     :town_number,      null: false
      t.string     :building_name
      t.string     :telephone_number, null: false
      t.references :purchase,         null: false, foreign_key: true

      t.timestamps
    end
  end
end
