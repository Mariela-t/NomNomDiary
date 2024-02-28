require 'faker'
FactoryBot.define do
  factory :recipe do 
    title { "Brownie" }
    category { "Dessert" }
    ingredients { "chocolate, flour, water, oil" }
    steps { "bake at 350 degrees for 20 minutes." }
    user 
  end
end
