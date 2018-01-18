require_relative '../lib/rts_api.rb'

module RtsApi
  describe GiftLoyaltyCardInformation do

     let (:gift_loyalty_card_information) do
       res = double("res", :code => 200, :body => '<Response><Version>1</Version><Code>-1</Code><Packet><GiftCard><GiftNumber>2012700000745808</GiftNumber><DebitRemain>1061.16</DebitRemain><Registered>0</Registered></GiftCard></Packet></Response>')
       ResponseFactory.create(:gift_loyalty_card_information, res)
     end
       
     it "can return the amount remaining" do
       debit_remain = gift_loyalty_card_information.debit_remain
       expect(debit_remain).to be == 1061.16
     end

     it "can indicate whether a card is registered or not"

     it "can return the member's name and address"

     it "can return ticket credits"

     it "can return item credits"
  end
end
