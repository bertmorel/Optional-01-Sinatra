require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @recettes = @cookbook.all
  erb :index
  # '<h1>Hello <em>world</em>!</h1>'
end

# get '/about' do
#   erb :about
# end

# get '/team/:username' do
#   puts params[:username]
#   "The username is #{params[:username]}"
# end

get '/new' do
  erb :new
end


post '/create' do
  # 1 create recipe
  recipe = Recipe.new(params[:name], params[:description], params[:duration], false)
  # 2 add to list
  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @cookbook.add_recipe(recipe)
  # @recettes = @cookbook.all
  redirect "/"
  # create recipe based on info
end

get '/destroy/:index' do
  index = params[:index].to_i
  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @cookbook.remove_recipe(index)
  # @recettes = @cookbook.all
  redirect "/"
end
