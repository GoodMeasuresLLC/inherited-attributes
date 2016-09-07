module Inherited
  module Attributes
    module ClassMethods
      def inherited_attribute(*fields_or_method)
        options = fields_or_method.extract_options!.reverse_merge({:default=>'nil'})
        fields_or_method.each do |method|
          eval <<-EOS
            class_eval do
              def effective_#{method}
                if @effective_#{method}.nil?
                  @effective_#{method} = (self.#{method}.blank? && !(self.#{method} == false)) ? inherited_#{method} : self.#{method}
                end
                @effective_#{method}
              end

              def inherited_#{method}
                if @inherited_#{method}.nil?
                  @inherited_#{method} = ancestors.map(&:#{method}).reject{ |val| val.blank? && !(val == false)}.compact.last
                  if (@inherited_#{method}.blank? && !(@inherited_#{method} == false))
                    @inherited_#{method} = self.class.new(:#{method} => #{options[:default]}).#{method}
                  end
                end
                @inherited_#{method}
              end
            end
          EOS
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end

ActiveRecord::Base.send :include, Inherited::Attributes
