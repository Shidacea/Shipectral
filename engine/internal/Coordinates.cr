module SF
  struct Vector2(T)
    def sdc_add(other)
      self + other
    end

    def sdc_subtract(other)
      self - other
    end

    def sdc_multiply(other)
      self * other
    end

    def sdc_dot(other)
      self.x * other.x + self.y * other.y
    end

    def sdc_squared_norm
      self.x * self.x + self.y * self.y
    end

    def sdc_to_s
      "#{self.x} #{self.y}"
    end

    def sdc_inspect
      "(#{self.x} | #{self.y})"
    end
  end

  # Experimental struct-wrapping class to avoid memory corruption
  class VectorWrapper2f
    property content : SF::Vector2f

    macro forward_function_from_content(function, operator = "")
      def {{function}}{{operator.id}}
        @content.{{function}}{{operator.id}}
      end  
    end

    def self.generate(new_content)
      self.new(new_content.x, new_content.y)
    end

    def initialize(x = 0.0, y = 0.0)
      @content = SF::Vector2f.new(x, y)
    end

    forward_function_from_content(x)
    forward_function_from_content(y)
    forward_function_from_content(x, operator: "=(value)")
    forward_function_from_content(y, operator: "=(value)")

    def sdc_add(other)
      self.class.generate(@content + other.content)
    end

    def sdc_subtract(other)
      self.class.generate(@content - other.content)
    end

    def sdc_multiply(other)
      self.class.generate(@content * other)
    end

    def sdc_dot(other)
      @content.sdc_dot(other.content)
    end

    forward_function_from_content(sdc_squared_norm)
    forward_function_from_content(sdc_to_s)
    forward_function_from_content(sdc_inspect)
  end
end

def setup_ruby_coordinates_class(mrb, module_sdc)
  MrbWrap.wrap_class(mrb, SF::VectorWrapper2f, "Coordinates", under: module_sdc)
  MrbWrap.wrap_constructor(mrb, SF::VectorWrapper2f, [{Float32, 0.0}, {Float32, 0.0}])
  MrbWrap.wrap_property(mrb, SF::VectorWrapper2f, "x", x, Float32)
  MrbWrap.wrap_property(mrb, SF::VectorWrapper2f, "y", y, Float32)
  MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "+", sdc_add, SF::VectorWrapper2f)
  MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "-", sdc_subtract, SF::VectorWrapper2f)
  MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "*", sdc_multiply, Float32)
  MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "dot", sdc_dot, SF::VectorWrapper2f)
  MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "squared_norm", sdc_squared_norm)
  MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "to_s", sdc_to_s)
  MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "inspect", sdc_inspect)
end
