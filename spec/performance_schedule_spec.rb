require_relative '../lib/rts_api.rb'

module RtsApi
    
  describe PerformanceSchedule do
      
    let(:performance_schedule) do
      res = double("res", :code => 200, :body => 
        <<~XML
          <Response>
            <ShowSchedule>
              <FileVersion>1.1</FileVersion>
              <RtsVersion>7.0.7238.0</RtsVersion>
              <LinkPreFix>https://www.readyticket.net/webticket/webticket2.aspWCI=BuyTicket&WCI=</LinkPreFix>
              <Tickets><Ticket><Code>1</Code><Name>Adult</Name><Price>7.5</Price><Tax>.5</Tax></Ticket><Ticket><Code>2</Code><Name>Child</Name><Price>7</Price><Tax>.43</Tax></Ticket></Tickets>
              <Films><Film><Title>+21 STRANGE TITLE</Title><TitleShort>+21 STRANGE TITLE</TitleShort><Length>120</Length><Rating>NC17</Rating><WebSite>http://www.rts-solutions.com</WebSite><FilmCode>+24230</FilmCode><MtFilmCode></MtFilmCode><Shows><Show><DT>200811261235</DT><Aud>1</Aud><ID>+24230|200811261235|1</ID><SaleLink>%2B21+STRANGE+TITLE,112620081235,1,5,NC17</SaleLink><RE>225</RE><Sold>22</Sold><SO>0</SO><LI>0</LI><TIs><TI><C>1|1</C></TI><TI><C>1|2</C></TI></TIs></Show></Shows></Film></Films>
            </ShowSchedule>
           </Response>
         XML
      )
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

    
  end

end
