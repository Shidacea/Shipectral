module SF 
    class Sound
        def set_sdc_sound_buffer(ptr : Pointer(SF::SoundBuffer))
            puts "SB = #{@_sound_buffer}"
            puts "B = #{ptr}"
            self.buffer = ptr.value
            puts "SB = #{@_sound_buffer}"
        end
    end
end

def setup_ruby_sound_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Sound, "Sound", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::Sound)

    #MrbWrap.wrap_setter(mrb, SF::Sound, "link_sound_buffer", buffer, SF::SoundBuffer)

    wrapped_method = MrbFunc.new do |mrb, obj|
        puts "MrbValue #{obj.value.value_pointer} of SF::Sound references #{MrbInternal.get_data_ptr(obj)}\n\n"

        raw_args = MrbMacro.get_raw_args(mrb, [SF::SoundBuffer])
        ruby_buffer = raw_args[0]

        sound = MrbMacro.convert_from_ruby_object(mrb, obj, SF::Sound)
        sound_buffer = MrbMacro.convert_from_ruby_object(mrb, ruby_buffer.value, SF::SoundBuffer)

        puts "MrbValue #{ruby_buffer.value.value.value_pointer} of SF::SoundBuffer references #{MrbInternal.get_data_ptr(ruby_buffer.value)}\n\n"

        sound.value.set_sdc_sound_buffer(sound_buffer)

        MrbInternal.get_true_value()
    end
    mrb.define_method("link_sound_buffer", MrbClassCache.get(SF::Sound), wrapped_method)

    MrbWrap.wrap_instance_method(mrb, SF::Sound, "play", play)
    MrbWrap.wrap_instance_method(mrb, SF::Sound, "stop", stop)
    MrbWrap.wrap_instance_method(mrb, SF::Sound, "pause", pause)
    MrbWrap.wrap_property(mrb, SF::Sound, "pitch", pitch, Float32)
    MrbWrap.wrap_property(mrb, SF::Sound, "volume", volume, Float32)
end