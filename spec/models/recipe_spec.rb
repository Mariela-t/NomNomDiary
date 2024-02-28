require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "associations" do
    it "belongs to a user" do
      user = FactoryBot.create(:user)
      recipe = FactoryBot.create(:recipe, user: user)
      expect(recipe.user).to eq(user)
    end
  end
end