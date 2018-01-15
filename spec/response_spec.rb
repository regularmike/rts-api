require_relative '../lib/rts_api.rb'

module RtsApi
  describe Response do
    it "has an error description when there is an error code" do
      @body = '<Response><Code>100</Code><ErrorText>Unknown Command - ShowTimeXmls</ErrorText></Response>'
      res = double("res", :code => 200, :body => @body)
      base_response = Response.new(res)
      expect(base_response.error_description).to be == 'Unknown Command - ShowTimeXmls'
    end

    it "has no error description when there is a success code" do
      @body = '<Response><Code>0</Code></Response>'
      res = double("res", :code => 200, :body => @body)
      base_response = Response.new(res)
      expect(base_response.error_description).to be_nil 
    end

    it "has no error description when there is no code" do
      @body = '<Response></Response>'
      res = double("res", :code => 200, :body => @body)
      base_response = Response.new(res)
      expect(base_response.error_description).to be_nil 
    end
  end
end
