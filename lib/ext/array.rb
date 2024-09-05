require_relative 'object'

module Ext
  module Array
    ##
    # @param [Hash]
    # @return [Object] First object that matches passed in key/value pairs
    # @example
    #   [{ a: 1 }, { b: 2 }].find_by(a: 1) => { a: 1 }
    def find_by(**attrs)
      find { |item| item.match?(**attrs) }
    end

    ##
    # @return [Array<Object>] all items that match all key/value pairs
    def where(**attrs)
      filter { |item| item.match?(**attrs) }
    end
  end
end

Array.include Ext::Array
Array.include Ext::Object
