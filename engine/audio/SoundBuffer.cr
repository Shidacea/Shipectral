module SF
  @[Anyolite::ExcludeInstanceMethod("open_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_file")]
  @[Anyolite::ExcludeInstanceMethod("load_from_samples")]
  @[Anyolite::ExcludeClassMethod("from_file")]
  @[Anyolite::ExcludeClassMethod("from_memory")]
  @[Anyolite::ExcludeClassMethod("from_stream")]
  @[Anyolite::ExcludeClassMethod("from_samples")]
  @[Anyolite::ExcludeConstant("Reference")]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class SoundBuffer
    @[Anyolite::Rename("load_from_file")]
    def load_from_sdc_path(filename : String)
      load_from_file(SDC::ScriptHelper.path + "/" + filename)
    end
  end
end

def setup_ruby_sound_buffer_class(rb)
  Anyolite.wrap(rb, SF::SoundBuffer, under: SF, verbose: true, connect_to_superclass: false)
end
