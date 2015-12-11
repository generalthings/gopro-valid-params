require 'active_support/hash_with_indifferent_access'
require 'active_model'
require 'valid_params/version'

module ValidParams
  autoload :Base,  'valid_params/base'
  autoload :Connector, 'valid_params/connector'
end
