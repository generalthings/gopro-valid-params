require 'action_controller'
require 'params_for'

class DummyController < ActionController::Base
  class ParamsFor::Dummy < ParamsFor::Base
    validates :id, presence: true
  end

  include ParamsFor::Connectors::Glue

end
