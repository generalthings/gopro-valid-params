# ValidParams

Use service objects and the power of `ActiveModel::Validations` to easy validate params in controller.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'valid_params'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install valid_params

## Usage

In your controller:


```Ruby
# app/controllers/fancy_controller.rb

class FancyController < ApplicationController
  include ValidParams::Connector

  def create
    validate_params :foo
    
    # do some stuff
    
    if all_valid? :foo, @some_model
      render @some_model, status: 201
    else
      render json: collect_errors(validator, *errorable), status: 422
    end
  end


  class ValidParams::Foo < ValidParams::Base
    validates :user_id, :fancy_name, presence: true
    validates :user_id, integer: true
  end
end
```