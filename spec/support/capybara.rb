# Capybara.javascript_driver = :selenium_chrome
# Capybara.javascript_driver = :selenium_chrome_headless
# require'capybara/poltergeist'
# Capybara.javascript_driver=:poltergeist

require 'capybara/rspec'
require 'selenium-webdriver'
driver = Selenium::WebDriver.for :chrome

# Capybara.javascript_driver = :selenium_chrome
Capybara.default_max_wait_time = 15
Capybara.javascript_driver = :selenium_chrome_headless

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  options.add_argument('--disable-gpu')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end