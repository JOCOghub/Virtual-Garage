class UsersController < ApplicationController

    get '/signup' do
      if current_user
        redirect '/tools'
      end
      erb :'users/signup'
    end
  
    post '/signup' do
      user = User.create(params)
      if user.valid?
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
      else
        flash[:message] = user.errors.full_messages#compare to this to tool/new and tool/edit
        redirect '/signup'
      end
    end
    
    get '/login' do
      if current_user
        redirect '/tools'
      end
        erb :'users/login'
    end
  
    post '/login' do
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        flash[:message] = "Invalid Login"
        erb :'/users/login'
      end
    end
  
    get '/users/:id' do
      @user = User.find_by(params)
      @tools = @user.tools
      erb :'users/show'
    end
  
    get '/logout' do
      session.clear
      redirect '/login'
    end
  
  end