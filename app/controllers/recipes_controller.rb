class RecipesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

 before_action :authenticate_user!, except: [:index, :show]
 before_action :set_recipe, only: [:show, :edit, :update, :destroy]


  def index
    @recipes = Recipe.all
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

        if @recipe.save
            flash.notice = "The recipe was created successfully"
            redirect_to @recipe
        else
            render :new
        end
    end

    def update
        if @recipe.update(recipe_params)
            redirect_to @recipe
        else
            render :edit
        end
    end

    def destroy
        set_recipe
        @recipe.destroy
        redirect_to recipes_path
    end

    private
def recipe_params
        params.require(:recipe).permit(:title, :category, :ingredients, :steps)
    end

def set_recipe
        @recipe = Recipe.find(params[:id])
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to recipes_path
end

end
