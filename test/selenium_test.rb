require "selenium-webdriver"
require "rspec"

include RSpec::Expectations

describe "Index" do
    before(:each) do
        @driver = Selenium::WebDriver.for :chrome
        @base_url = "http://localhost:3000"
        @driver.manage.timeouts.implicit_wait = 30
        @verification_errors = []
        @data = [["0","0"],["1","1"],["3","11"],["5","101"],["7","111"],["9","1001"]]
    end

    after(:each) do
        @driver.quit
        expect(@verification_errors).to eql([])
    end
    
    it "test_lab9" do
        @driver.get(@base_url )
        @driver.find_element(:name, "n").clear
        @driver.find_element(:name, "n").send_keys "30"
        @driver.find_element(:name, "commit").click
        (2..6).each do |x|
            verify{expect(@driver.find_element(:xpath, "/html/body/table/tbody/tr[#{x}]/td[1]").text).to eql(@data[x-2][0])}
            verify{expect(@driver.find_element(:xpath, "/html/body/table/tbody/tr[#{x}]/td[2]").text).to eql(@data[x-2][1])}
        end
    end
    
    def verify(&blk)
        yield
        rescue ExpectationNotMetError => ex
        @verification_errors << ex
    end
end
