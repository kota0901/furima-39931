require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '情報の保存' do

    context '内容に問題ない場合' do
      it "すべての値が正しく入力されていれば保存できること" do
        expect(@order_address).to be_valid
      end

      it "建物名が空でも保存可能" do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
    end
  end

    context '内容に問題がある場合' do
      it "post_codeが空だと保存できないこと" do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")

      end

      it "post_codeはハイフン必須" do
        @order_address.post_code = "1234567"
        @order_address.valid?

        expect(@order_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")

      end

      it "post_codeは数字7桁必須" do
        @order_address.post_code = "123-456"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")

      end

      it "cityは空不可" do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")

      end
      it "banchiは空不可" do
        @order_address.banchi = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Banchi can't be blank")

      end

      it "number空不可" do
        @order_address.number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Number can't be blank")

      end

      it "数字でない文字が含まれる場合は無効であること" do
        @order_address.number = "abc1234567"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Number is invalid. Input only number")
      end

      it "12桁の電話番号なら無効であること" do
        @order_address.number = "090123456789"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Number is invalid. Input only number")

      end

      it "9桁の電話番号なら無効であること" do
        @order_address.number = "012345678"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Number is invalid. Input only number")
      end

      it "region選択していないと保存できないこと" do
          @order_address.region_id = 1
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Region can't be blank")

        end

      it "userが紐付いていないと保存できないこと" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it "itemが紐付いていないと保存できないこと" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it "トークンがなければ無効であること" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")

      end
    end
  end
end