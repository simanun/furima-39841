require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品の購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '商品の購入ができるとき' do
      it 'token,post_code,prefecture_idなど必須項目が存在すれば登録できる' do
        expect(@purchase_address).to be_valid
      end
      it 'building_nameは空でも登録できる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end
    context '商品の購入ができないとき' do
      it 'tokenが空では登録できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_codeが空では登録できない' do
        @purchase_address.post_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと登録できない' do
        @purchase_address.post_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが1のままでは登録できない' do
        @purchase_address.prefecture_id = '1'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では登録できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end
      it 'town_numberが空では登録できない' do
        @purchase_address.town_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Town number can't be blank")
      end
      it 'telephone_numberが空では登録できない' do
        @purchase_address.telephone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberが全角では登録できない' do
        @purchase_address.telephone_number = '１１１１１１１１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Telephone number is not a number')
      end
      it 'telephone_numberが数値以外では登録できない' do
        @purchase_address.telephone_number = 'abcdefghijk'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Telephone number is not a number')
      end
      it 'telephone_numberが10桁未満では登録できない' do
        @purchase_address.telephone_number = '111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Telephone number is too short or too long')
      end
      it 'telephone_numberが11桁以上では登録できない' do
        @purchase_address.telephone_number = '11111111111111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Telephone number is too short or too long')
      end
      it 'userが紐付いていないと登録できない' do
        @purchase_address.user_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと登録できない' do
        @purchase_address.item_id = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
