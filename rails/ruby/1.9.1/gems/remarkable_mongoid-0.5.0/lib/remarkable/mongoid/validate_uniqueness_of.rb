module Remarkable::Mongoid
  module Matchers
    def validate_uniqueness_of(attr)
      ValidateUniquenessOfMatcher.new(attr)
    end
    
    class ValidateUniquenessOfMatcher
      attr_accessor :attr, :validation_type, :message, :scope

      def initialize(attr)
        self.attr = attr.to_sym
      end
      
      def with_message(message)
        self.message = message
        self
      end
      
      def scoped_to(scope)
        self.scope = scope.to_sym
        self
      end

      def matches?(subject)
        @subject    = subject
        validations = @subject._validators[attr]
        if validations
          validation = validations.detect { |k| k.class == ::Mongoid::Validations::UniquenessValidator }
          validation && check_option(validation, :message) && check_option(validation, :scope)
        else
          false
        end
      end

      def description
        "validates that :#{attr} is unique"
      end

      def failure_message_for_should
        "\nUniqueness validation failure\nExpected: '#{attr}' to be unique"
      end
      
      private
      
      def check_option(validation, option)
        if self.send(option)
          validation.options[option] == self.send(option)
        else
          true
        end
      end
    end
    
  end
end