class UsersController < ApplicationController

    get '/users' do
      redirect_if_not_logged_in
      @users = User.all
      erb :'users/index'
    end
  
    get '/users/new' do
      redirect_if_not_logged_in
      erb :'users/new'
    end
  
    post '/users' do
      redirect_if_not_logged_in
      user = User.create(params) 
      if user.valid?      
        user.admin_id = session[:admin_id]   
        user.save                       
        redirect "/users/#{user.id}"         
      else 
        flash[:message] = user.errors.full_messages 
        redirect '/users/new'   
      end   
    end
  
    get '/users/:id' do
      redirect_if_not_logged_in
      if @user = User.find_by(params)
        erb :'users/show'
      else
        flash[:message] = "The user you looked for was not found"
        redirect '/users'
      end
  
    end
  
    get '/users/:id/edit' do
      redirect_if_not_logged_in
      @user = User.find_by(params)
      if !check_owner(@user)
        flash[:message] = "That user isn't yours!!"
        redirect '/users'
      end
      erb :'users/edit'
    end
  
    patch '/users/:id' do
      redirect_if_not_logged_in
      @tool = User.find_by(id: params[:id])
      if check_owner(@tool)
        @tool.update(params[:tool])
      end
        erb :'tools/show'
    end
  
    delete '/tools/:id' do
      redirect_if_not_logged_in
      tool = User.find_by(id: params[:id])
      if check_owner(tool)
          tool.delete
      end
        redirect '/tools'
    end
  
  
  end