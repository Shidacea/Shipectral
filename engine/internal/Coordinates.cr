def setup_ruby_coordinates_class(mrb, module_sdc)
  MrbWrap.wrap(mrb, SF::VectorWrapper2f, under: SF, verbose: true)
  # MrbWrap.wrap_constructor(mrb, SF::VectorWrapper2f, [{Float32, 0.0}, {Float32, 0.0}])
  # MrbWrap.wrap_property(mrb, SF::VectorWrapper2f, "x", x, Float32)
  # MrbWrap.wrap_property(mrb, SF::VectorWrapper2f, "y", y, Float32)
  # MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "+", sdc_add, SF::VectorWrapper2f)
  # MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "-", sdc_subtract, SF::VectorWrapper2f)
  # MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "*", sdc_multiply, Float32)
  # MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "dot", sdc_dot, SF::VectorWrapper2f)
  # MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "squared_norm", sdc_squared_norm)
  # MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "to_s", sdc_to_s)
  # MrbWrap.wrap_instance_method(mrb, SF::VectorWrapper2f, "inspect", sdc_inspect)
end
