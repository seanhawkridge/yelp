require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the RestaurantsHelper. For example:
#
# describe RestaurantsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
# RSpec.describe RestaurantsHelper, type: :helper do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

def signup
  visit '/'
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def signup_two
  visit '/'
  click_link('Sign up')
  fill_in('Email', with: 'two@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def create_restaurant
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'Wagamama'
  click_button 'Create Restaurant'
end
