# frozen_string_literal: true

require_relative 'ext/object'
require_relative 'ext/array'

module Attrs
  def self.included(base)
    base.include(InstanceMethods)
  end

  class << self
    def included(base)
      base.include(InstanceMethods)
    end

    def version
      config[:version]
    end

    def config
      YAML.load_file(File.join(__dir__, '..', 'config.yml'))
    end
  end

  module InstanceMethods
    def attrs(*attrs)
      return list_attrs(attrs) if is_list?

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

      base_attrs = base_attrs.to_h do |attr|
        [attr, get(attr)]
      end
      nested_attrs.reduce(base_attrs, :merge)
    end
    alias oattrs attrs

    private

    ##
    # Returns a hash containing attributes on the list and attributes on individual items.
    # @param attrs [Array]
    # @return [Hash]
    def list_attrs(attrs)
      list, nested = attrs.partition { |attr| attr.is_a?(Symbol) && respond_to?(attr) }
      list_attrs = list.empty? ? {} : list.to_h { |key| [key, get(key)] }
      nested_attrs = nested.empty? ? {} : { items: map { |i| i.attrs(*nested) } }

      merged_attrs = list_attrs.merge(nested_attrs)
      merged_attrs = merged_attrs[:items] if merged_attrs.keys == [:items]

      merged_attrs
    end

    ##
    # Recursively retrieves nested attributes.
    #
    # @param attr [Array | Hash]
    def nested_attrs(attr)
      attr.to_h do |key, value|
        [key, get(key).attrs(*value)]
      end
    end

    ##
    # Gets a single attribute for any object. If the object is a hash, it will return the value for the key.
    #
    # @param key [Symbol]
    # @return [Object]
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

    ##
    # Hacky way of determining if a non-hash object is a list but is not
    #   technically an Array or Enumerable (e.g. ActiveRecord::Relation)
    def is_list?
      respond_to?(:each) && !is_a?(Hash)
    end
  end
end

Object.include Attrs
