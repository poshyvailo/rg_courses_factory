# Factory class
class Factory

  def self.new(*arguments, &block)

    # Create class name
    class_name = if arguments.first.is_a? String
                   unless /^[A-Z]/ =~ arguments.first
                     raise(NameError, "identifier #{arguments.first} needs to be constant")
                   end
                   arguments.shift
                 else
                   nil
                 end

    # Create class instance
    class_instance = Class.new do

      attr_accessor *arguments

      # initialize
      define_method :initialize do |*class_arguments|

        if class_arguments.size > arguments.size
          raise ArgumentError.new('struct size differs')
        end

        class_arguments.each_with_index do |value, index|
          instance_variable_set("@#{arguments[index]}", value)
        end

      end

      # to_s
      define_method :to_s do

        key_value_attributes = arguments.map do |variable|
          value = instance_variable_get("@#{variable}")
          ":#{variable.to_s}=" << value.inspect
        end

        "#<factory #{self.class.name} #{key_value_attributes.join(' ')}>"
      end

      # ==
      def ==(other)
        other.class == self.class && other.values == self.values
      end

      # []
      def [](key)
        if key.is_a? Integer
          key = members[key].to_s.tr('@', '')
        end
        instance_variable_get "@#{key}"
      end

      # []=
      def []=(key, value)
        instance_variable_set("@#{key}", value)
      end

      # size
      def size
        self.values.size
      end

      # values
      def values
        members.map { |a| instance_variable_get("#{a}") }
      end

      def members
        instance_variables
      end

      # alias inspect -> to_s
      alias_method :inspect, :to_s
      alias_method :length, :size
      alias_method :values, :to_a
      alias_method :members, :to_h

      # Eval block
      class_eval(&block) if block_given?
    end

    # Define and return class
    class_name ? const_set(class_name, class_instance) : class_instance
  end
end