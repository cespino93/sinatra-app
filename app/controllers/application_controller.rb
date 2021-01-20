require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_awesome_journal_app"
  end

  get "/" do
    # redirect '/login'
    if logged_in?
      redirect "/users/#{current_user}"
    
    else
    erb :welcome
    end
  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user
    end

  def current_user
    @current_user ||= user.find(id: session[:user_id])
  end

end
end
