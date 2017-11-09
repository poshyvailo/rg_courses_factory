class Factory

  def self.new(*attributes, &block)

    if attributes.first.is_a? String
      class_name = attributes.shift
    else
      class_name = nil
    end

    class_instance = Class.new do

      attr_accessor *attributes

      class_eval(&block) if block_given?

      define_method :initialize do |*construct_attributes|

        if construct_attributes.size > attributes.size
          raise ArgumentError.new('struct size differs')
        end

        construct_attributes.each_with_index do |value, index|
          instance_variable_set("@#{attributes[index]}", value)
        end

      end

      define_method :to_s do

        key_value_attributes = attributes.map do |variable|
          value = instance_variable_get("@#{variable}")
          ":#{variable.to_s}=" << value.inspect
        end

        "#<factory #{self.class.name} #{key_value_attributes.join(' ')}>"
      end

      alias_method :inspect, :to_s

      def [](key)
        p "Test #{key}"
      end

    end

    class_name ? const_set(class_name, class_instance) : class_instance

  end
end