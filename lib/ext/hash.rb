module Ext
  module Hash
    def method_missing(method_name, *args, &block)
      if key?(method_name.to_s)
        self.class.define_method(method_name) do
          self[method_name.to_s]
        end
  
        send(method_name)
      elsif key?(method_name.to_sym)
        self.class.define_method(method_name) do
          self[method_name.to_sym]
        end
  
        send(method_name)
      else
        super
      end
    end
  
    def respond_to_missing?(method_name, *args, &block)
      key?(method_name.to_s) || key?(method_name.to_sym) || super
    end
  end
end

Hash.include Ext::Hash
