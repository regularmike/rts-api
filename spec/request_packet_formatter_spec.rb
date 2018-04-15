require_relative '../lib/rts_api/request_packet_formatter.rb'
require_relative '../lib/rts_api/credit_card.rb'

module RtsApi
  describe RequestPacketFormatter do

    it "includes the requested version number" do
      formatter = RequestPacketFormatter.new(2)
      packet = formatter.performance_schedule
      expect(packet.at('Version')).to_not be_nil
      expect(packet.at('Version').text).to eql '2'
    end
    
    describe "#performance_schedule" do
      formatter = RequestPacketFormatter.new(1)

      it "includes a Command node with innert text 'ShowTimeXml'" do
        packet = formatter.performance_schedule      
        expect(packet.at('Command').text).to eql 'ShowTimeXml'
      end

      it "includes a ShowAvalTickets node when show_aval_tickets is true" do
        packet = formatter.performance_schedule(show_aval_tickets: true)
        expect(packet.at('ShowAvalTickets')).to_not be_nil
        expect(packet.at('ShowAvalTickets').text).to eql '1'
      end
      
      it "includes a ShowSales node when show_sales is true" do
        packet = formatter.performance_schedule(show_sales: true)
        expect(packet.at('ShowSales')).to_not be_nil
        expect(packet.at('ShowSales').text).to eql '1'
      end

      it "includes a ShowSaleLinks node when show_sale_links is true" do
        packet = formatter.performance_schedule(show_sale_links: true)
        expect(packet.at('ShowSaleLinks')).to_not be_nil
        expect(packet.at('ShowSaleLinks').text).to eql '1'
      end
    end

    describe "#gift_card_loyalty_card_information" do
      formatter = RequestPacketFormatter.new(1)

      it "includes the requested gift card number" do
        packet = formatter.gift_card_loyalty_card_information('123456')
        expect(packet.at('GiftCard').text).to eql '123456'
      end
    end

    describe "#gift_card_purchase" do
      formatter = RequestPacketFormatter.new(1)
      card = CreditCard.new(
        number: '5499990123456781',
        expiration: '0513',
        avs_street: '4 Main St',
        avs_postal: '30329',
        cid: '123',
        name_on_card: 'John Doe'
      )
      packet = formatter.gift_card_purchase(amount: 25, card: card)

      it "includes an amount element" do
        expect(packet.at('Amount').text).to eql '25'
      end
    end
  end
end
