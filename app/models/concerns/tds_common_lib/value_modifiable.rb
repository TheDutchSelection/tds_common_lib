module TdsCommonLib
  module ValueModifiable
    extend ActiveSupport::Concern

    def add_as_array(value_1, value_2)
      self.class.add_as_array(value_1, value_2)
    end

    def value_to_array(value)
      self.class.value_to_array(value)
    end

    class_methods do
      def add_as_array(value_1, value_2)
        value_to_array(value_1) + value_to_array(value_2)
      end

      def value_to_array(value)
        unless value.is_a?(Array)
          if value.blank?
            value = []
          else
            value = [].push(value)
          end
        end

        value.compact
      end
    end

  end


end