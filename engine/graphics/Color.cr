module SF
    struct Color
        def sdc_add(other)
            self + other
        end

        def sdc_subtract(other)
            self - other
        end

        def sdc_multiply(other)
            self * other
        end

        # TODO: Find a better way to do this
        def object_id
            0.to_u64
        end
    end
end

def setup_ruby_color_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Color, "Color", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::Color, [{UInt8, 0}, {UInt8, 0}, {UInt8, 0}, {UInt8, 255}])
    MrbWrap.wrap_instance_method(mrb, SF::Color, "to_i", to_integer)
    MrbWrap.wrap_property(mrb, SF::Color, "r", r, UInt8)
    MrbWrap.wrap_property(mrb, SF::Color, "g", g, UInt8)
    MrbWrap.wrap_property(mrb, SF::Color, "b", b, UInt8)
    MrbWrap.wrap_property(mrb, SF::Color, "a", a, UInt8)
    MrbWrap.wrap_instance_method(mrb, SF::Color, "+", sdc_add, [SF::Color])
    MrbWrap.wrap_instance_method(mrb, SF::Color, "-", sdc_subtract, [SF::Color])
    MrbWrap.wrap_instance_method(mrb, SF::Color, "*", sdc_multiply, [SF::Color])
    MrbWrap.wrap_instance_method(mrb, SF::Color, "to_s", to_s)
    MrbWrap.wrap_instance_method(mrb, SF::Color, "inspect", inspect)
end