
module ActsAsAggregateRoot  #:nodoc:
  def self.included(base)
    base.extend(ClassMethods)
  end
  module ClassMethods
    def acts_as_aggregate_root
      
      def add_destroy_methods_to_class(klass)
        klass.reflections.select {|(k,v)| v.macro == :has_many }.each {|(name,reflection)|
           add_destroy_method(klass,name.to_s)
           reflection.options[:autosave] = true
           add_destroy_methods_to_class(reflection.klass)
        }
      end


      def add_destroy_method(klass,reflection_name)
        klass.instance_eval do
          method_name = "has_many_dependent_destroy_for_#{reflection_name}".to_sym
          define_method(method_name) do
            send(reflection_name).each { |o| o.destroy }
          end
          before_destroy method_name
        end 
      end 

      self.instance_eval do
        def has_many(association_id, options = {}, &extension)
          # options .merge! :autosave => true , :dependent => :destroy 
          super
          reflection = create_has_many_reflection(association_id, options, &extension)
          reflection.options[:autosave] = true
          add_destroy_method(self,reflection.name)
          add_destroy_methods_to_class(reflection.klass)
        end
      end
    end
  end
end
