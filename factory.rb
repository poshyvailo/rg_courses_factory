# Factory class
class Factory

  def self.new(*arguments, &block)

    class_name = if arguments.first.is_a? String
                   unless arguments.first.match?(/^[A-Z]/)
                     raise(NameError, "identifier #{arguments.first} needs to be constant")
                   end
                   arguments.shift
                 end

    class_instance = Class.new do

      attr_accessor *arguments

      def initialize(*class_arguments)
        if class_arguments.size > members.size
          raise(ArgumentError, 'struct size differs')
        end
        class_arguments.each_with_index { |value, index| self[index] = value }
      end

      def to_s
        attributes_list = to_h.map { |key, value| "#{key}=#{value.inspect}" }
        "#<factory #{self.class.name} #{attributes_list.join(' ')}>"
      end

      def ==(other)
        to_s == other.to_s
      end

      def [](key)
        key = members[key] if key.is_a? Integer
        instance_variable_get "@#{key}"
      end

      def []=(key, value)
        instance_variable_set("@#{key}", value)
      end

      def size
        members.size
      end

      def values
        members.map { |key| self[key] }
      end

      def values_at(*selectors)
        to_a.values_at(*selectors)
      end

      def select(&block)
        to_a.select(&block)
      end

      def each(&block)
        values.each(&block)
      end

      def each_pair(&block)
        to_h.each_pair(&block)
      end

      def dig(*key)
        to_h.dig(*key)
      end

      def to_h
        members.each_with_object({}) do |name, hash|
          hash[name] = self[name]
        end
      end

      define_method :members do
        arguments
      end

      alias_method :inspect, :to_s
      alias_method :length, :size
      alias_method :to_a, :values

      class_eval(&block) if block_given?
    end

    class_name ? const_set(class_name, class_instance) : class_instance
  end
end
