module SF
    class Texture
        def load_from_sdc_path(filename, texture_rect)
            load_from_file(ScriptHelper.path + "/" + filename, texture_rect)
        end
    end
end

def setup_ruby_texture_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Texture, "Texture", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::Texture)
    MrbWrap.wrap_instance_method(mrb, SF::Texture, "size", size)
    # TODO: Fix this as soon as Anyolite allows for default object values (either nil or omitting them) 
    # Alternatively, implement the method manually
    MrbWrap.wrap_instance_method(mrb, SF::Texture, "load_from_file", load_from_sdc_path, [String, SF::IntRect])
end