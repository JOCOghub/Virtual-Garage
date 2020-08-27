class ToolsController < ApplicationController

    get '/tools' do
      redirect_if_not_logged_in
      @tools = Tool.all
      erb :'tools/index'
    end
  
    get '/tools/new' do
      redirect_if_not_logged_in
      erb :'tools/new'
    end
  
    post '/tools' do
      redirect_if_not_logged_in
      tool = Tool.create(params) 
      if tool.valid?      
        tool.user_id = session[:user_id]   
        tool.save                       
        redirect "/tools/#{tool.id}"         
      else 
        flash[:message] = tool.errors.full_messages 
        redirect '/tools/new'#just edited    
      end   
    end
  
    get '/tools/:id' do
      redirect_if_not_logged_in
      if @tool = Tool.find_by(params)
        erb :'tools/show'
      else
        flash[:message] = "The tool you looked for was not found"
        redirect '/tools'
      end
  
    end
  
    get '/tools/:id/edit' do
      redirect_if_not_logged_in
      @tool = Tool.find_by(params)
      if !check_owner(@tool)
        redirect '/tools'
      end
      erb :'tools/edit'
    end
  
    patch '/tools/:id' do
      redirect_if_not_logged_in
      @tool = Tool.find_by(id: params[:id])
      if check_owner(@tool)
        @tool.update(params[:tool])
      end
        erb :'tools/show'
    end
  
    delete '/tools/:id' do
      redirect_if_not_logged_in
      tool = Tool.find_by(id: params[:id])
      if check_owner(tool)
          tool.delete
      end
        redirect '/tools'
        #maybe add flash message here "That tool isn't yours!!"
    end
  
  
  end