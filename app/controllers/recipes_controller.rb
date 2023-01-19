class RecipesController < ApplicationController

# shows all recipes made by all users
    def index
        if User.find_by(id: session[:user_id])
            recipes = Recipe.all
            render json: recipes, status: :ok
        else
            render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end

# shows just recipes made by user that is logged in
    # def index
    #     recipes = Recipe.all.where(id: session[:user_id])
    #     render json: recipes, status: :ok
    # end

    def create
        if User.find_by(id: session[:user_id])
            recipe = current_user.recipes.create!(recipe_params)
            render json: recipe, status: :created
        else
            render json: { errors: ["Invalid username or password"] }, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def current_user
        user = User.find_by(id: session[:user_id])
    end

end
