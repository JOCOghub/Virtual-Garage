require './config/environment'
require 'sass/plugin/rack'

use Sass::Plugin::Rack
use Rack::MethodOverride
use AdminsController
use UsersController
run ApplicationController