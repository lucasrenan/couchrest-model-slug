require 'stringex'

module CouchRest
  module Model
    module Slug
      extend ActiveSupport::Concern
      
      included do
        before_save :generate_slug
        
        property :slug
        view_by :slug
        view_by :slug_without_count, 
          :map => "function(doc) {
            if ((doc['#{self.model_type_key}'] == '#{self.name}') && (doc['slug'] != null)) {
              var slug = doc['slug'].match(/^(\\S+?)(?:-\\d+)?$/);
              emit(slug[1], null);
            }
          }",
          :reduce => "_count"

        cattr_accessor :slugged_props
      end
      
      module ClassMethods
        def slug(*props)
          self.slugged_props = props.map(&:to_s)
        end
        
        def find(value)
          self.by_slug(:key => value).first || super(value)
        end
        
        def generate_count_for_slug(slug_without_count)
          hash = self.by_slug_without_count(:reduce => true, :group => true, :key => slug_without_count)["rows"].try(:first)
          hash.nil? ? slug_without_count : "#{slug_without_count}-#{hash['value']}"
        end
      end

      def to_param
        result = self.send :slug
        return super if result.blank?
        result
      end
      
      private
      def generate_slug
        if new_record? || slugged_props_changed?
          slug = self.slugged_props.collect{ |prop| read_attribute(prop) }.join(", ").to_url
          slug = self.class.generate_count_for_slug(slug)
          self.slug = slug
        end
      end

      def slugged_props_changed?
        self.slugged_props.any? { |p| self.send("#{p}_changed?") }
      end
      
    end
  end
end