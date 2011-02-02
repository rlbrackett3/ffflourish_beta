# remarkable_mongoid
NOTE: This gem is based upon the 2.0 beta of Mongoid and the 4.0 alpha of Remarkable

RSpec Matchers for Mongoid

## Matchers

Fields

* have_field

Associations

* reference_one
* reference_many
* be_referenced_in
* embed_one
* embed_many
* be_embedded_in

Validations

* validate_uniqueness_of
* validate_association
* All ActiveModel validations from [Remarkable::ActiveModel](http://github.com/remarkable/remarkable/tree/master/remarkable_activemodel)

## Installation

    gem install remarkable_mongoid

## Usage

    require 'remarkable/mongoid'

    describe Book do
      it { should reference_one :author }
    end
    
## Copyright

Copyright (c) 2010 Brian Cardarella. See LICENSE for details.
