module CouchRest
  module Model
    module Slug
      extend ActiveSupport::Concern
      
      included do

        cattr_accessor :slugged_props
      end
      
      module InstanceMethods
      end
      
      module ClassMethods
        def slug(*props)
          self.slugged_props = props.map(&:to_s)
        end
      end
    end
  end
end