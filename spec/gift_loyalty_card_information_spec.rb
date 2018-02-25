require_relative '../lib/rts_api.rb'

module RtsApi
  describe GiftLoyaltyCardInformation do

    before :all do
      @body = File.read("#{__dir__}/sample_responses/gift_card_loyalty_card_information.xml")
    end
    
    let :gift_loyalty_card_information do
      res = double('res', code: 200, body: @body)
      ResponseFactory.create(:gift_loyalty_card_information, res)
    end

    it "can return the amount remaining" do
      debit_remain = gift_loyalty_card_information.debit_remain
      expect(debit_remain).to be 1061.16
    end

    it "can indicate whether a card is registered or not" do
      registered = gift_loyalty_card_information.registered?
      expect(registered).to be true
    end

    it "can return the member's name and address" do
      registered_info = gift_loyalty_card_information.registered_info
      expect(registered_info.first_name).to eq 'JOHN'
      expect(registered_info.last_name).to eq 'DOE'
      expect(registered_info.address1).to eq '4 DOE ROAD'
      expect(registered_info.address2).to be_empty
      expect(registered_info.city).to eq 'DOEVILLE'
      expect(registered_info.state).to eq 'DO'
      expect(registered_info.postal).to eq '11111'
    end

    it "can return ticket credits" do
      ticket_credits = gift_loyalty_card_information.ticket_credits
      expect(ticket_credits[0].amount).to be == 1
      expect(ticket_credits[0].expiration).to be == 'None'
      expect(ticket_credits[1].start_date).to be == '20130405000000'
      expect(ticket_credits[1].title_restriction).to be == 'WORLD WAR Z'
      expect(ticket_credits[1].ticket_restriction).to be == ''
    end

    it "can return item credits" do
      item_credits = gift_loyalty_card_information.item_credits
      expect(item_credits[0].expiration).to be == 'None'
      expect(item_credits[0].start_date).to be == '20130426000000'
      expect(item_credits[0].amount).to be == 1
      expect(item_credits[0].item).to be == 'SM POPCORN'
    end
  end
end
