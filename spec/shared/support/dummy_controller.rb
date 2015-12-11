require 'action_controller'
require 'valid_params'

class DummyController < ActionController::Base
  class ValidParams::Dummy < ValidParams::Base
    validates :id, presence: true
  end

  include ValidParams::Connectors::Glue

end
