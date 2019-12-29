require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  # get '/' do
  #   "Bookmark Manager"
  # end

  get '/bookmarks' do
    p ENV
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect "/bookmarks"
  end

  post '/bookmarks' do
    url = params['url']
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
  redirect '/bookmarks'
  end

  run! if app_file == $0
  
end