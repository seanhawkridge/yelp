include ActionDispatch::TestProcess

FactoryGirl.define do

  factory :restaurant do
    name {Faker::Name.name}
    image { fixture_file_upload './spec/images/bbc-g.jpg', 'image/jpg' }
    user
  end

  factory :restaurant_params, class: Restaurant do
    name {Faker::Name.name}
    image { fixture_file_upload './spec/images/bbc-g.jpg', 'image/jpg' }
  end

end
