require "selenium/webdriver"


Capybara.register_driver :firefox do |app|

  profile = Selenium::WebDriver::Firefox::Profile.new
  profile["intl.accept_languages"] = "pt-BR"
  
  Capybara::Selenium::Driver.new(app, :browser => :firefox, :profile => profile)
end