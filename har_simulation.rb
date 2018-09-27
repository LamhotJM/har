
require 'capybara'
require 'capybara/dsl'
require 'browsermob/proxy'
require 'selenium-webdriver'

include Capybara::DSL

# Download browsermob-proxy.
# Set JAVA_HOME for browsermob proxy

# Before
server = BrowserMob::Proxy::Server.new("/Users/lamhotjmsiagian/browsermob-proxy-2.1.4/bin/browsermob-proxy") 
server.start
proxy = server.create_proxy
caps = Selenium::WebDriver::Remote::Capabilities.chrome(:proxy => proxy.selenium_proxy)

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :desired_capabilities => caps)
end

Capybara.current_driver = :chrome

# Test
proxy.new_har "Stackoverflow"
visit "https://www.bukalapak.com/"
har = proxy.har

# work with *.har
puts har.entries.first.request.url # => http://stackoverflow.com/questions/6588390/where-is-java-home-on-osx-yosemite-10-10-mavericks-10-9-mountain-lion-10
puts har.entries.first.response.status  # => 200
har.save_to "stackoverflow.har"

# After
proxy.close