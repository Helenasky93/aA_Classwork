FactoryBot.define do
    # name of the model 
    factory :user do
        username { Faker::Movies::HarryPotter.character } #generates a random username
        email { Faker::Internet.email }
        password { 'password' }
        age { 5 }
        political_affiliation { Faker::Movies::HarryPotter.house }
    end
end