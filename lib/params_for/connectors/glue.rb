require 'active_support/concern'

module ParamsFor
  module Connectors
    module Glue
      extend ActiveSupport::Concern

      def validator_for(validator)
        validator_name = "ParamsFor::#{validator.to_s.classify}"
        validator_klass = validator_name.constantize
        validator_klass.new(params)
      end

      def validate_params(validator)
        validator = validator_for(validator)

        if validator.valid?
          @params_valid = true
        else
          @params_errors = validator.errors
          @params_valid = false
        end
      end

      def params_valid?(validator)
        validate_params(validator) if @params_valid.nil?
        @params_valid
      end

      def resources_valid?(*resources)
        !!(resources.map(&:valid?).include?(false)) #possibly optimize this by exiting as soon as theres a false
      end

      def all_valid?(validator, *resources)
        params_valid  = params_valid?(validator)
        resources_valid = resources_valid? resources
        #need to make sure both methods are called and nothing exists early
        params_valid && resources_valid
      end

      def collect_errors(validator, *errorable)
        errorable.map(&:valid?) #must validate everything to compile the list of errors
        errors = errorable.collect(&:errors)
        errors << @params_errors if !params_valid? validator
        errors.map(&:to_hash).reduce{|accumulator, e| merge_hashes_of_arrays(accumulator, e)}
      end

      def merge_hashes_of_arrays(a,b)
        a.merge(b){ |k, old_value, new_value| (old_value | new_value) }
      end

    end
  end
end
