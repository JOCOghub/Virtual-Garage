class ApplicationController < Sinatra::Base

    configure do
      set :views, 'app/views'
      enable :sessions
      set :session_secret, "Ryansecrest" 
    end
  
    register Sinatra::Flash
  
    get '/' do
      erb :'home'
    end
  
    helpers do
        def current_admin
          @current_admin ||=  Admin.find_by(id: session[:admin_id])
        end
  
        def redirect_if_not_logged_in
          if !current_admin
            flash[:message] = "You must log in to see that page"
            redirect '/login'
          end
        end
  
        def check_owner(obj)
          obj.admin == current_admin
        end
  
    end
  
  
  
  end