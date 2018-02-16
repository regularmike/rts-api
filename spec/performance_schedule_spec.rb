require_relative '../lib/rts_api.rb'

module RtsApi
  describe PerformanceSchedule do

    before :all do
      @body = File.read("#{__dir__}/sample_responses/performance_schedule.xml")
    end
      
    let(:performance_schedule) do
      res = double("res", :code => 200, :body => @body)
      ResponseFactory.create(:performance_schedule, res)
    end

    it "can return the file version" do
      file_version = performance_schedule.file_version
      expect(file_version).to be == '1.1'
    end

    it "can return the rts version" do
      rts_version = performance_schedule.rts_version
      expect(rts_version).to be == '7.0.7238.0'
    end

    it "can return the link prefix" do
      link_prefix = performance_schedule.link_prefix
      expect(link_prefix).to be == 'https://www.readyticket.net/webticket/webticket2.aspWCI=BuyTicket&WCI='
    end

    it "can return an array of tickets" do
      tickets = performance_schedule.tickets
      expect(tickets[0].code).to be == '1'
    end

    it "can return an array of films" do
      films = performance_schedule.films
      expect(films[0].rating).to be == 'NC17'
    end
   
    it "can set an array of shows for each film" do
      films = performance_schedule.films
      expect(films[0].shows[0].datetime).to be == '200811261235'
    end
   
    it "can set an array of ticket codes for each show" do
      films = performance_schedule.films
      expect(films[0].shows[0].ticket_type_codes[0]).to be == '1|1'
    end
  end
end
