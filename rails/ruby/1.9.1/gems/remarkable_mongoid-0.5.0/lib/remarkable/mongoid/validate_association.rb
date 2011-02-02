module Remarkable::Mongoid
  module Matchers
    def validate_association(attr)
      ValidateAssociationMatcher.new(attr)
    end
    
    class ValidateAssociationMatcher
      attr_accessor :attr

      def initialize(attr)
        self.attr = attr.to_sym
      end
      
      def matches?(subject)
        @subject    = subject
        validations = @subject._validators[attr]
        validations.detect { |k| k.class == ::Mongoid::Validations::AssociatedValidator }
      end

      def description
        "validates the :#{attr} association"
      end

      def failure_message_for_should
        "\nAssociation validation failure\nExpected: #{@subject.class} to validate the '#{attr}' association"
      end
      
    end
    
  end
end