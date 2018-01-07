require_relative '../lib/rts_api/request_packet_formatter.rb'

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

      it "includes a ShowAvalTickets node when show_available_tickets is true" do
        packet = formatter.performance_schedule(show_available_tickets: true)
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
  end
end
