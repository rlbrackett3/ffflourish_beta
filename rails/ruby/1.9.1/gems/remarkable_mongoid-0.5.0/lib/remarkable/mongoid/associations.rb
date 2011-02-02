module Remarkable::Mongoid
  module Matchers
    def reference_one(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::ReferencesOne)
    end
    
    def reference_many(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::ReferencesMany)
    end

    def reference_many_as_array(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::ReferencesManyAsArray)
    end
    
    def be_referenced_in(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::ReferencedIn)
    end

    def embed_one(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::EmbedsOne)
    end
    
    def embed_many(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::EmbedsMany)
    end
    
    def be_embedded_in(attr)
      AssociationMatcher.new(attr, ::Mongoid::Associations::EmbeddedIn)
    end
    
    class AssociationMatcher
      attr_accessor :attr, :association_type

      def initialize(attr, association_type)
        self.attr             = attr.to_s
        self.association_type = association_type
      end

      def matches?(subject)
        @subject     = subject
        associations = @subject.associations.select { |k,v| v.association == association_type }
        associations.detect { |k| k.first == attr } != nil
      end

      def description
        "has #{humanized_association} association :#{attr}"
      end
      
      def failure_message_for_should
        "\n#{humanized_association} association failure\nExpected: '#{attr}'"
      end
      
      private
      
      def humanized_association
        association_type.to_s.split('::').last
      end
    end
  end
end
