Given /^I have no fees$/ do
  Fee.delete_all
end

Given /^I (only )?have fees titled "?([^\"]*)"?$/ do |only, titles|
  Fee.delete_all if only
  titles.split(', ').each do |title|
    Fee.create(:from_account => title)
  end
end

Then /^I should have ([0-9]+) fees?$/ do |count|
  Fee.count.should == count.to_i
end

#cucumber generated

Given /^I am a logged in refinery user$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^I have role member$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I go to the list of fees$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I follow "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I press "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end