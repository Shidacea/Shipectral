module SF
    class Sound
        def link_sound_buffer(new_buffer)
            buffer = new_buffer
        end
    end
end

def setup_ruby_sound_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Sound, "Sound", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::Sound)

    MrbWrap.wrap_instance_method(mrb, SF::Sound, "link_sound_buffer", link_sound_buffer, SF::SoundBuffer)

    MrbWrap.wrap_instance_method(mrb, SF::Sound, "play", play)
    MrbWrap.wrap_instance_method(mrb, SF::Sound, "stop", stop)
    MrbWrap.wrap_instance_method(mrb, SF::Sound, "pause", pause)
    MrbWrap.wrap_property(mrb, SF::Sound, "pitch", pitch, Float32)
    MrbWrap.wrap_property(mrb, SF::Sound, "volume", volume, Float32)
end