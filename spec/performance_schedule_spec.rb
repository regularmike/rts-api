require_relative '../lib/rts_api.rb'

module RtsApi
    
  describe PerformanceSchedule do

    before :all do
      @body = File.read("#{__dir__}/sample_responses/performance_schedule.rb")
    end
      
    let(:performance_schedule) do
      res = double("res", :code => 200, :body => @body)
      ResponseFactory.create(:performance_schedule, res)
    end

    it "can return the file version" do
      file_version = performance_schedule.file_version
      expect(file_version).to_not be_nil
    end

    it "can return the rts version" do
      rts_version = performance_schedule.rts_version
      expect(rts_version).to_not be_nil
    end

    it "can return the link prefix" do
      link_prefix = performance_schedule.link_prefix
      expect(link_prefix).to_not be_nil
    end

    it "can return an array of tickets" do
      tickets = performance_schedule.tickets
      expect(tickets[0]).to be_an_instance_of(Ticket)
    end

    it "can return an array of films" do
      films = performance_schedule.films
      expect(films[0]).to be_an_instance_of(Film)
    end
   
    it "can set an array of shows for each film" do
      films = performance_schedule.films
      expect(films[0].shows[0]).to be_an_instance_of(Show)
    end
   
    it "can set an array of ticket codes for each show" do
      films = performance_schedule.films
      expect(films[0].shows[0].ticket_type_codes).to be_an_instance_of(Array)
    end

  end

end
