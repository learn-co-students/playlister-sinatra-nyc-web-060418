require 'pry'
require 'rack-flash'

class SongsController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions
  use Rack::Flash
  use Rack::MethodOverride


  get '/' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs/new' do
    @song = Song.new

    erb :"/songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/show"
  end

  post '/songs' do
    @song = Song.create(params[:song])
    @song.update(name: params[:song][:name])

    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])

    @song.genres = params[:genres].collect {|num| Genre.find(num)}

    @song.save
    flash[:message] = "Successfully created song."
    redirect "/songs/#{ @song.slug }"
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/edit"
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(name: params[:song][:name])

    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])

    @song.genres = params[:genres].collect {|num| Genre.find(num)}

    @song.save
    flash[:message] = "Successfully updated song."

    redirect "/songs/#{ @song.slug }"
  end

end
