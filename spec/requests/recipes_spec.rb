require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  describe "GET /recipes" do
    it "renders the index" do
      user = FactoryBot.create(:user)
      sign_in user
      get "/recipes"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET /recipes/:id" do
    it "renders the show" do
      user = FactoryBot.create(:user)
      sign_in user 
      recipe = FactoryBot.create(:recipe, user: user)
      get "/recipes/#{recipe.id}"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "GET /recipes/new" do
    it "renders the new" do
      user = FactoryBot.create(:user)
      sign_in user 
      get "/recipes/new"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe "GET /recipes/:id/edit" do
    it "renders the edit" do
      user = FactoryBot.create(:user)
      sign_in user 
      recipe = FactoryBot.create(:recipe, user: user)
      get "/recipes/#{recipe.id}/edit"
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "POST /recipes" do
    it "created new recipe" do
      user = FactoryBot.create(:user)
      sign_in user 
      get "/recipes", params: {recipe: FactoryBot.attributes_for(:recipe)}
      expect(response).to redirect_to(assigns(:recipe))
      follow_redirect!
      expect(response).to render_template(:show)
    end 
  end 

  describe "PUT /recipes/:id" do
    it "updates a recipe" do
      user = FactoryBot.create(:user)
      sign_in user
      recipe = FactoryBot.create(:recipe, user: user)
      put "/recipes/#{recipe.id}", params: { recipe: FactoryBot.attributes_for(:recipe) }
      expect(response).to redirect_to(assigns(:recipe))
      follow_redirect!
      expect(response).to render_template(:show)
    end
  end

  describe "DELETE /recipes/:id" do
    it "deletes a recipe" do
      user = FactoryBot.create(:user)
      sign_in user
      recipe = FactoryBot.create(:recipe, user: user)
      delete "/recipes/#{recipe.id}"
      expect(response).to redirect_to(recipes_path)
    end
  end

end
