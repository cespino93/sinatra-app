class CreateRecipesController < ApplicationController
    
    get '/create_recipes' do
        @recipes = Recipe.all
        erb :'/create_recipes/index'
    end

    get '/create_recipes/new' do
        erb :'/create_recipes/new'
    end
    

    post '/create_recipes' do
        if !logged_in?
            redirect '/'
    end
        
        
        if params[:content] != ""
            @create_recipes = current_user.recipes.build(params)
            @create_recipes.save
            redirect "/create_recipes"
        else
            redirect '/create_recipes/new'
        end
    end


    get '/create_recipes/:id' do
        # @create_recipe = Recipe.find_by(id: params[:id])
        set_create_recipe
        erb :'/create_recipes/show'
    end


    get '/create_recipes/:id/edit' do
        # @create_recipe = Recipe.find_by(id: params[:id])
        set_create_recipe
        if logged_in?
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
        # @create_recipe = Recipe.find_by(id: params[:id])
        set_create_recipe
        if logged_in?
            if @create_recipe.user == current_user && params[:content] != ""
        @create_recipe.update(content: params[:content])
        redirect "/create_recipes/#{@create_recipe.id}"
        else
                redirect "users/#{current_user.id}"
            end
        else
            redirect '/'
        end
    end 

    delete '/create_recipes/:id' do
        # @create_recipe = Recipe.find_by(id: params[:id])
        set_create_recipe
        if authorized_to_edit?(@create_recipe)
            @create_recipe.destroy
            redirect '/create_recipes'
        else
            redirect '/create_recipes'
        end
    end

    private

    def set_create_recipe
        @create_recipe = Recipe.find_by(id: params[:id]) 
    end

end