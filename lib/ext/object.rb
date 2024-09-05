module Ext
  module Object
    ##
    # @return [Boolean] whether all key/value pairs match
    def match?(**args)
      args.all? do |key, value|
        key_value_match?(key, value)
      end
    end

    def key_value_match?(key, value)
      if respond_to?(:[])
        attribute = self[key]
        return true if attribute == value
        return true if attribute.respond_to?(value) && attribute.send(value)
      end

      if respond_to?(key)
        attribute = send(key)
        return true if attribute == value
        return true if attribute.respond_to?(value) && attribute.send(value)
      end

      return false
    rescue TypeError, NoMethodError, NameError, ArgumentError
      false
    end
  end
end

Object.include Ext::Object
