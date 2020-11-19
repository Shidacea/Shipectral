module SF
  class SoundBuffer
    def load_from_sdc_path(filename)
      load_from_file(ScriptHelper.path + "/" + filename)
    end
  end
end

def setup_ruby_sound_buffer_class(mrb, module_sdc)
  MrbWrap.wrap_class(mrb, SF::SoundBuffer, "SoundBuffer", under: SF)
  MrbWrap.wrap_constructor(mrb, SF::SoundBuffer)
  MrbWrap.wrap_instance_method(mrb, SF::SoundBuffer, "load_from_file", load_from_sdc_path, [String])
end
