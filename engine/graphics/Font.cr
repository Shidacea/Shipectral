module SF
  class Font
    def load_from_sdc_path(filename)
      load_from_file(ScriptHelper.path + "/" + filename)
    end
  end
end

def setup_ruby_font_class(mrb, module_sdc)
  MrbWrap.wrap_class(mrb, SF::Font, "Font", under: SF)
  MrbWrap.wrap_constructor(mrb, SF::Font)
  MrbWrap.wrap_instance_method(mrb, SF::Font, "load_from_file", load_from_sdc_path, [String])
end
