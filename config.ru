require './config/environment'
require 'sass/plugin/rack'

use Sass::Plugin::Rack
use Rack::MethodOverride
use UsersController
use ToolsController
run ApplicationController