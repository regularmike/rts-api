require_relative '../lib/rts_api.rb'

module RtsApi
  describe GiftCardPurchase do

    before :all do
      @body = File.read("#{__dir__}/sample_responses/gift_card_purchase.xml")
    end

    let :gift_card_purchase do
      res = double('res', code: 200, body: @body)
      ResponseFactory.create(:gift_card_purchase, res)
    end
    
    it "can provide the new gift card number" do
      number = gift_card_purchase.gift_number
      expect(number).to eq '1234-1234-1234-1234'
    end

    it "can provide the transaction ID" do
      transaction_id = gift_card_purchase.transaction_id
      expect(transaction_id).to eq '1476206'
    end

    it "can have mulitple gift card purchases"

    it "can provide the response code"

    it "can provide the response text"

    it "can provide amount"
  end
end
