When /^I am in (.*) browser$/ do |name|
  Capybara.session_name = name
end

Given /^(.*) and (.*) are at the same url$/ do |first_name, second_name|
  Capybara.default_wait_time = 5
  Capybara.session_name = first_name
  visit "/"
  url = current_url
  puts url
  Capybara.session_name = second_name
  visit url
 
end

When /^(.*) writes (.*) to the chat$/ do |name, message|
  Capybara.session_name = name
  fill_in 'message', :with => message
  find_button('chat-submit').click
end

Then /^(.*) should see (.*)$/ do |name, text|
  Capybara.session_name = name
  page.should have_content(text)
end

When /^(.*) tries to send empty message to the chat$/ do |name|
  Capybara.session_name = name
  fill_in 'chat-message', :with => ''
  fill_in 'chat-name', :with => name
end

Then /^(.*) cant send the message$/ do |name|
   Capybara.session_name = name
   find('#chat-submit')['disabled'].should == 'true'
  
end

When /^(.*) tries to send message without username to the chat$/ do |name|
  Capybara.session_name = name
  fill_in 'chat-message', :with => 'something'
  fill_in 'chat-name', :with => ''
end