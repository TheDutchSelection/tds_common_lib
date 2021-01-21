module TdsCommonLib
  module RecordsLimitable
    extend ActiveSupport::Concern

    def limit_records_by_type(collection, limit, type_method = nil)
      counter = {}
      collection.each do |record|
        key = type_method.nil? ? 'all' : record.public_send(type_method)
        if counter.has_key?(key)
          if counter[key] >= limit
            record.destroy
          end
          counter[key] += 1
        else
          counter[key] = 1
        end
      end
    end
  end
end