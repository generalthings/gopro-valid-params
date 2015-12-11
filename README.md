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
  include ValidParams::Connectors::Glue

  valid_params :fancy, only: [:create]

  # Creates a Fancy object by checking and validating params
  # before that
  #
  def create
    ...
    @fancy = Fancy.new(fancy_params)
    ...
  end
end
```

Or you can play with it yourself

```Ruby
# app/controllers/fancy_controller.rb

class FancyController < ApplicationController
  include ValidParams::Connectors::Glue

  # Creates a Fancy object by checking and validating params
  # before that
  #
  def create
    ...
    @fancy = Fancy.new(fancy_params)
    ...
  end

  protected

  # Strong params delegated to ValidParams::Fancy
  # and memoized in @fancy_params var returned by this method
  #
  # @return [HashwithIndifferentAccess]
  def fancy_params
    valid_params :fancy
  end
end
```

Some place in your application ( suggested `app/validators/valid_params/` )

```Ruby
  # app/validators/valid_params/fancy.rb

  class ValidParams::Fancy < ValidParams::Base
    attr_accessor :user_id, :fancy_name, :fancy_description

    validates :user_id, :fancy_name, presence: true
    validates :user_id, integer: true
  end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/valid_params/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
