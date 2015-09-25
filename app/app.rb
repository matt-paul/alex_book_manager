require 'sinatra/base'
require_relative 'data_mapper_setup.rb'
require 'sinatra/flash'
# require 'byebug'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect '/links'
  end

  get '/links' do

  	@links = Link.all
  	erb :'links/index'

  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links/new' do
    link = Link.new(url: params[:url], title: params[:title])
    tag_names = params[:tags].split(' ')
    tag_names.each do |name|
    link.tags << Tag.first_or_create(name: name)
    end
    link.save
    redirect ('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
  	@links = tag ? tag.links : []
  	erb :'links/index'
  end

  get '/users/new' do
  @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    if params[:email] == ""
      flash.now[:notice] = "You must enter a valid email address"
      erb :'users/new'

    elsif @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
    end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
