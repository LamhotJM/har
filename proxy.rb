require 'selenium-webdriver'
require 'browsermob/proxy'

server = BrowserMob::Proxy::Server.new("/Users/lamhotjmsiagian/browsermob-proxy-2.1.4/bin/browsermob-proxy") 
server.start
proxy = server.create_proxy

caps = Selenium::WebDriver::Remote::Capabilities.chrome(:proxy => proxy.selenium_proxy)
driver = Selenium::WebDriver.for(:chrome, :desired_capabilities => caps)

# Test
proxy.new_har "Test"
driver.get "http://www.staging6.vm"
har = proxy.har 
# work with *.har
puts har.entries.first.request.url 
puts har.entries.first.response.status 
har.save_to "test.har"

# After
proxy.close
driver.quit