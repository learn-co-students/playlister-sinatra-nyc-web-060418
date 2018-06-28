require 'pry'

class SongsController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs' do
    @songs = Song.all
    erb :"/songs/index"
  end

  get '/songs/new' do
    erb :"/songs/new"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/show"
  end

  post '/songs' do
    @song = Song.create(name: params[:song][:name])

    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])

    # if !Artist.all.find_by(name: params[:artist][:name])
    #   @song.artist = Artist.create(name: params[:artist][:name])
    #   @song.artist.save
    #   #binding.pry
    # end

    redirect "/songs/#{@song.slug}"
  end
end
