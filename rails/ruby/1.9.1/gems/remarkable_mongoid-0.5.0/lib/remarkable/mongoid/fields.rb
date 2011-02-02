module Remarkable::Mongoid
  module Matchers
    def have_field(field, options = {})
      HasFieldMatcher.new(field, options)
    end

    class HasFieldMatcher
      attr_accessor :field, :options

      def initialize(field, options)
        self.field   = field.to_s
        self.options = { :type => String }.merge(options)
      end

      def matches?(subject)
        @subject     = subject.is_a?(Class) ? subject : subject.class
        @subject.fields.has_key?(field) && (@subject.fields[field].type == options[:type])
      end

      def description
        "have field #{field} #{humanized_options}"
      end

      def failure_message_for_should
        "expected #{@subject} to have field #{field} #{humanized_options}"
      end

      def failure_message_for_should_not
        "expected #{@subject} to not have field #{field} #{humanized_options}"
      end

      private

      def humanized_options
        "of type #{options[:type]}"
      end
    end
  end
end
