require_relative '../lib/rts_api/request_packet_formatter.rb'

module RtsApi

  describe RequestPacketFormatter do

    it "should include the requested version number" do
      formatter = RequestPacketFormatter.new(2)
      packet = formatter.performance_schedule
      expect(packet.at('Version')).to_not be_nil
      expect(packet.at('Version').text).to eql '2'
    end
    
    describe "#performance_schedule" do
      formatter = RequestPacketFormatter.new(1)

      it "should add a Command node with innert text 'ShowTimeXml'" do
        packet = formatter.performance_schedule      
        expect(packet.at('Command').text).to eql 'ShowTimeXml'
      end

      it "should add a ShowAvalTickets node when first parameter is true" do
        packet = formatter.performance_schedule(true)
        expect(packet.at('ShowAvalTickets')).to_not be_nil
        expect(packet.at('ShowAvalTickets').text).to eql '1'
      end
      
      it "should add a ShowSales node when second parameter is true" do
        packet = formatter.performance_schedule(false, true)
        expect(packet.at('ShowSales')).to_not be_nil
        expect(packet.at('ShowSales').text).to eql '1'
      end

      it "should add a ShowSaleLinks node when third parameter is true" do
        packet = formatter.performance_schedule(false, false, true)
        expect(packet.at('ShowSaleLinks')).to_not be_nil
        expect(packet.at('ShowSaleLinks').text).to eql '1'
      end

    end

  end

end
