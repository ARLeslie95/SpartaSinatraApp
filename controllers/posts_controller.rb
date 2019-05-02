
class PostController < Sinatra::Base
  #Set the root of the parent directory of the current File
  set :root, File.join(File.dirname(__FILE__), '..')

  # Sets  the view directory correctly
  set :views, Proc.new   {File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  $movies = [{
    id: 0,
    title: "Avengers: Endgame",
    director: "Russo bros"
  },
  {
    id: 1,
    title: "Star Wars",
    director: "George Lucas"
  },
  {
    id: 2,
    title: "LOTR",
    director: "Peter Jackson"
  }]

  get "/" do

    @title = "Movie Database"
    @movies = $movies

    erb :'movies/index'
  end

  get "/new" do

    @title = "Add new entry"
    @movie = {
      id: "",
      title: "",
      director: ""
    }

    erb :'movies/new'

  end

  get "/:id"do
    id = params[:id].to_i
    @movie = $movies[id]
    @title = @movie[:title]
    erb :'movies/show'

  end

  post "/" do

    new_movie = {
      id: $movies.length,
      title: params[:title],
      director: params[:director]
    }
    $movies.push(new_movie)
    redirect "/"

  end

  get "/:id/edit" do
    id = params[:id].to_i
    @movie = $movies[id]
    @title = "Edit entry"

    erb :'movies/edit'
  end

  put "/:id" do
    id = params[:id].to_i
    movie = $movies[id]

    movie[:title] = params[:title]
    movie[:director] = params[:director]

    $movies[id] = movie

    redirect "/"
  end

  delete "/:id" do
    id = params[:id].to_i

    $movies.delete_at(id)

    redirect "/"
  end
end
