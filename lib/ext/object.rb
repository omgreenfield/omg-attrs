module Ext
  module Object
    ##
    # @return [Boolean] whether all key/value pairs match
    # TODO: allow this to call children recursively, e.g. Ticket.where(ready?: true, repos: { name: 'medely' })
    # TODO: add this method to `Array` so we do Repo.find_by(name: 'medely').prs.where(...)
    def match?(**args)
      args.all? do |key, value|
        binding.pry
        is_a?(Hash) ? self[key] == value : send(key) == value
      end
    end
  end
end

::Object.include Ext::Object
