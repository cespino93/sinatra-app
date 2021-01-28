class CreateRecipesController < ApplicationController
    
    get '/create_recipes' do
        @recipes = Recipe.all
        erb :'/create_recipes/index'
end

    # get create_recipes/new to render a form to create new entry
    get '/create_recipes/new' do
        erb :'/create_recipes/new'
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
            # @create_recipe = CreateRecipe.create(content: params[:content], user_id: current_user.id)
            @create_recipes = current_user.recipes.build(params)
            @create_recipes.save
            redirect "/create_recipes"
        else
            redirect '/create_recipes/new'
        end
    end

    # show route for a recipe
    get '/create_recipes/:id' do
        # @create_recipe = CreateRecipe.find(params[:id])
        @create_recipe = Recipe.find_by(id: params[:id])
        # set_create_recipe
        # erb :show
        erb :'/create_recipes/show'
    end

    # This route should send us to create_recipes/edit.erb which will
    # render an edit form
    get '/create_recipes/:id/edit' do
        @create_recipe = Recipe.find_by(id: params[:id])
        if logged_in?
        # if @create_recipe.user == current_user
        if authorized_to_edit?(@create_recipe) 
            erb :'/create_recipes/edit'
        else
            redirect "users/#{current_user.id}"
        end
    else
        redirect '/'
    end
end

    patch '/create_recipes/:id/edit' do
        # 1. Find the Recipe Entry
        @create_recipe = Recipe.find_by(id: params[:id])
        if logged_in?
            if @create_recipe.user == current_user && params[:content] != ""
        # 2. modify (update) the journal entry
        @create_recipe.update(content: params[:content])
        # 3. redirect to show page
        redirect "/create_recipes/#{@create_recipe.id}"
        else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end 

    delete '/create_recipes/:id' do
        @create_recipe = Recipe.find_by(id: params[:id])
        if authorized_to_edit?(@create_recipe)
            @create_recipe.destroy
            redirect '/create_recipes'
        else
            redirect '/create_recipes'
        end
    end
    
    
    
    # index route for all recipes
    #SAVE FOR ASSESSMENT
    
    # private #Private, means were not going to call anywhere else outside this class

    # def set_create_recipe
    #     @create_recipe = Recipe.find_by(id: params[:id]))
    # end
end