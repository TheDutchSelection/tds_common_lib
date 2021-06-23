module TdsCommonLib
  module Booleanable
    extend ActiveSupport::Concern

    def to_boolean(value)
      self.class.to_boolean(value)
    end

    def is_boolean_value(value)
      self.class.is_boolean_value(value)
    end

    class_methods do
      def to_boolean(value)
        case value
        when 'true', 1, '1', true
          true
        else
          false
        end
      end

      def is_boolean_value(value)
        case value
        when 'true', 1, '1', true, 'false', 0, '0', false
          true
        else
          false
        end
      end
    end
    
  end


end