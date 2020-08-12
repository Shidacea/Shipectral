module SF
    class Music
        def load_from_sdc_path(filename)
            open_from_file(ScriptHelper.path + "/" + filename)
        end
    end
end

def setup_ruby_music_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Music, "Music", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::Music)
    MrbWrap.wrap_instance_method(mrb, SF::Music, "play", play)
    MrbWrap.wrap_instance_method(mrb, SF::Music, "stop", stop)
    MrbWrap.wrap_instance_method(mrb, SF::Music, "pause", pause)
    MrbWrap.wrap_property(mrb, SF::Music, "looping", loop, Bool)
    MrbWrap.wrap_property(mrb, SF::Music, "pitch", pitch, Float32)
    MrbWrap.wrap_property(mrb, SF::Music, "volume", volume, Float32)
    MrbWrap.wrap_instance_method(mrb, SF::Music, "open_from_file", load_from_sdc_path, [String])
end