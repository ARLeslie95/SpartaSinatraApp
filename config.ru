require 'sinatra'
require 'sinatra/contrib'
require_relative './controllers/posts_controller'

use Rack::MethodOverride

run PostController
