require_relative '../lib/rts_api.rb'

module RtsApi
    
  describe PerformanceSchedule do
      

    it "can return the file version" do
      file_version = @performance_schedule.file_version
      expect(file_version).to_not be_nil
    end

    it "can return the rts version" do
      rts_version = @performance_schedule.rts_version
      expect(rts_version).to_not be_nil
    end

    it "can return the link prefix" do
      link_prefix = @performance_schedule.link_prefix
      expect(link_prefix).to_not be_nil
    end

    it "can return an array of tickets" do
      tickets = @performance_schedule.tickets
      expect(tickets).to be_an_instance_of(Array)
    end

    before(:each) do
      res = double("res", :code => 200, :body => 
        '<Response>
          <ShowSchedule>
            <FileVersion>1.1</FileVersion>
            <RtsVersion>7.0.7238.0</RtsVersion>
            <LinkPreFix>https://www.readyticket.net/webticket/webticket2.aspWCI=BuyTicket&WCI=</LinkPrefix>
            <Tickets>
              <Ticket>
                <Code>1</Code>
                <Name>Adult</Name>
                <Price>7.5</Price>
                <Tax>.5</Tax>
              </Ticket>
              <Ticket>
                <Code>2</Code>
                <Name>Child</Name>
                <Price>7</Price>
                <Tax>.43</Tax>
              </Ticket>
            </Tickets>
          </ShowSchedule>
         </Response>')
      @performance_schedule = PerformanceSchedule.new(res)
    end
    
  end

end
