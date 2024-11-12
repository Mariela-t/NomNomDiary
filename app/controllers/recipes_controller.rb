class RecipesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

 before_action :authenticate_user!
 before_action :set_recipe, only: [:show, :edit, :update, :destroy]


  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe
    unless @recipe
      flash[:error] = "Recipe not found"
      redirect_to recipes_path
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

   def create
        @recipe = Recipe.new(recipe_params)
        @recipe.user_id = current_user.id
        if @recipe.save
            flash.notice = "The recipe was created successfully"
            redirect_to @recipe
        else
            render :new, status: 400
        end
    end

    def update
        if @recipe.update(recipe_params)
          @recipe.avatar.attach(params[:avatar]) if params[:avatar].present?
            redirect_to @recipe
        else
            render :edit, status: 400
        end
    end

    def destroy
        set_recipe
        if @recipe
       @recipe.destroy
       redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
      else
       redirect_to recipes_path, alert: 'Recipe not found.'
      end
    end

    private
def recipe_params
        params.require(:recipe).permit(:title, :category, :ingredients, :steps, :avatar)
    end

def set_recipe
        @recipe = Recipe.find_by(id: params[:id], user_id: current_user.id)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to recipes_path
end

end
