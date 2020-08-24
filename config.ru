require './config/environment'

use Rack::MethodOverride
use UsersController
use ToolsController
run ApplicationController