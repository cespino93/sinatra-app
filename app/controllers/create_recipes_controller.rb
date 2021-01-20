class CreateRecipesController < ApplicationController

    # get create_recipes/new to render a form to create new entry
    get '/create_recipes/new' do
        erb :'create_recipes/new'
    end
    # post create_recipes to create a new recipe
    post '/create_recipes' do
    
    end

    # show route for a recipe

    # index route for all recipes
end