module SF
  @[Anyolite::ExcludeInstanceMethod("open_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_file")]
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::ExcludeClassMethod("from_file")]
  @[Anyolite::ExcludeClassMethod("from_memory")]
  @[Anyolite::ExcludeClassMethod("from_stream")]
  @[Anyolite::ExcludeClassMethod("from_samples")]
  class SoundBuffer
    @[Anyolite::Rename("load_from_file")]
    @[Anyolite::WrapWithoutKeywords]
    def load_from_sdc_path(filename : String)
      load_from_file(ScriptHelper.path + "/" + filename)
    end
  end
end

def setup_ruby_sound_buffer_class(rb)
  Anyolite.wrap(rb, SF::SoundBuffer, under: SF, verbose: true, wrap_superclass: false)
end
