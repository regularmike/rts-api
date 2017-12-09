require_relative '../lib/rts_api.rb'

module RtsApi

  describe ResponseFactory do

    before(:each) do  
      @res = double("res", :code => 200, :body => '<Response></Response>')
    end
    
    it "creates a PerformanceSchedule when command is :performance_schedule" do
      response = ResponseFactory.create(:performance_schedule, @res)
      expect(response).to be_an_instance_of PerformanceSchedule
    end

    it "creates a generic Response when command is unknown" do
      response = ResponseFactory.create(:some_unknown_command, @res)
      expect(response).to be_an_instance_of Response
    end
  
  end

end
