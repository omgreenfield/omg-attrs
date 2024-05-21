# frozen_string_literal: true

require 'pry-byebug'

module Attrs
  def self.included(base)
    base.include(InstanceMethods)
  end

  module InstanceMethods
    def attrs(*attrs)
      binding.pry
      #TODO: handle the existing failing spec
      return map { |i| i.attrs(*attrs) } if is_list?(self)

      base_attrs, nested_attrs = attrs.partition { |attr| attr.is_a?(Symbol) }
      nested_attrs.map! do |attr|
        if attr.is_a?(Hash)
          nested_attrs(attr)
        elsif attr.is_a?(Array) && attr.size == 2 && attr.first.is_a?(Symbol)
          nested_attrs([attr].to_h)
        elsif attr.is_a?(Array)
          attr.map { |a| a.attrs(a) }
        else
          raise ArgumentError, "Invalid attribute: #{attr}"
        end
      end

      base_attrs = base_attrs.to_h { |attr| [attr, get(attr)] }
      nested_attrs.reduce(base_attrs, :merge)
    end

    private

    def nested_attrs(attr)
      attr.to_h do |key, value|
        records = get(key)

        values = is_list?(records) ?
          records.map { |record| record.attrs(*value) } :
          records.attrs(*value)

        [key, values]
      end
    end

    def get(key)
      if respond_to?(key)
        send(key)
      elsif is_a?(Hash)
        self[key]
      else
        # Denoting that the object does not respond to that key
        NilClass
      end
    end

    def is_list?(object)
      object.is_a?(Enumerable) && !object.is_a?(Hash)
    end
  end
end

Object.include Attrs
