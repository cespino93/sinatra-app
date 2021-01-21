class CreateRecipesController < ApplicationController

    # get create_recipes/new to render a form to create new entry
    get '/create_recipes/new' do
        erb :'create_recipes/new'
    end
    # post create_recipes to create a new recipe
    post '/create_recipes' do
        # I want to create a new recipe and save it to the database
        # I also only want to create a recipe if a user is logged in
        if !logged_in?
            redirect '/'
        end
        # I only want to save the entry if it has some content
        if params[:content] != ""
            # create a new entry
            @create_recipe = CreateRecipe.create(content: params[:content], 
            user_id: current_user.id)
            redirect "/create_recipes/#{@create_recipe.id}"
        else
            redirect '/create_recipes/new'
        end
    end

    # show route for a recipe
    
    # index route for all recipes
end