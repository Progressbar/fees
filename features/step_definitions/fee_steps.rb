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
