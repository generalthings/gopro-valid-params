# app/validators/param_validator/base.rb

module ParamsFor
  class Base
    include ActiveModel::Validations

    def initialize(params = {})
      @params = ActiveSupport::HashWithIndifferentAccess.new(params)
    end

    def method_missing *args
      @params[args.first]
    end

  end
end
