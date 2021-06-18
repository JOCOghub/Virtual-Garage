class AdminsController < ApplicationController

    get '/signup' do
      if current_admin
        redirect '/users'
      end
      erb :'admins/signup'
    end
  
    post '/signup' do
      admin = Admin.create(params)
      if admin.valid?
        session[:admin_id] = admin.id
        redirect "/admins/#{admin.id}"
      else
        flash[:message] = admin.errors.full_messages.to_sentence
        redirect '/signup'
      end
    end
    
    get '/login' do
      if current_admin
        redirect '/users'
      end
        erb :'admins/login'
    end
  
    post '/login' do
      @admin = Admin.find_by(username: params[:username])
      if @admin && @admin.authenticate(params[:password])
        session[:admin_id] = @admin.id
        redirect "/admins/#{@admin.id}"
      else
        flash[:message] = "Invalid Login"
        erb :'/admins/login'
      end
    end
  
    get '/admins/:id' do
      @admin = Admin.find_by(params)
      @users = @admin.users
      erb :'admins/show'
    end
  
    get '/logout' do
      session.clear
      redirect '/login'
    end

    get '/admins/:id/edit' do 
      @admin = Admin.find_by(params)
        if @admin == current_admin
          erb :'admins/edit'
        else 
          flash[:message] = "That is not your profile"
          redirect "admins/#{@admin.id}"
        end  
    end

    patch '/admins/:id' do
      @admin = Admin.find_by(id: params[:id])
      @admin.update(params[:admin])
      @users = @admin.users
      erb :'admins/show'
    end 
  
end