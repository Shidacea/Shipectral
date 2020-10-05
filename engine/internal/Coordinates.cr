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
end

def setup_ruby_coordinates_class(mrb, module_sdc)
  MrbWrap.wrap_class(mrb, SF::Vector2f, "Coordinates", under: module_sdc)
  MrbWrap.wrap_constructor(mrb, SF::Vector2f, [{Float32, 0.0}, {Float32, 0.0}])
  MrbWrap.wrap_property(mrb, SF::Vector2f, "x", x, Float32)
  MrbWrap.wrap_property(mrb, SF::Vector2f, "y", y, Float32)
  MrbWrap.wrap_instance_method(mrb, SF::Vector2f, "+", sdc_add, SF::Vector2f)
  MrbWrap.wrap_instance_method(mrb, SF::Vector2f, "-", sdc_subtract, SF::Vector2f)
  MrbWrap.wrap_instance_method(mrb, SF::Vector2f, "*", sdc_multiply, Float32)
  MrbWrap.wrap_instance_method(mrb, SF::Vector2f, "dot", sdc_dot, SF::Vector2f)
  MrbWrap.wrap_instance_method(mrb, SF::Vector2f, "squarded_norm", sdc_squared_norm)
  MrbWrap.wrap_instance_method(mrb, SF::Vector2f, "to_s", sdc_to_s)
  MrbWrap.wrap_instance_method(mrb, SF::Vector2f, "inspect", sdc_inspect)
end
