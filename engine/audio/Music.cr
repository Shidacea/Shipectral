module SF
  @[Anyolite::ExcludeInstanceMethod("open_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("open_from_file")]
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::ExcludeClassMethod("from_file")]
  @[Anyolite::ExcludeClassMethod("from_memory")]
  @[Anyolite::ExcludeClassMethod("from_stream")]
  @[Anyolite::ExcludeConstant("Span")]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Music
    @[Anyolite::Rename("open_from_file")]
    def load_from_sdc_path(filename : String)
      open_from_file(SDC::ScriptHelper.path + "/" + filename)
    end

    def looping=(value : Bool)
      self.loop = value
    end

    @[Anyolite::SpecifyGenericTypes([T])]
    @[Anyolite::SpecializeInstanceMethod("initialize", [offset = T.zero, length = T.zero], [offset : T = T.new, length : T = T.new])]
    struct Span(T)
    end
  end
end

def setup_ruby_music_class(rb)
  Anyolite.wrap_class(rb, SF::SoundStream, "SoundStream", under: SF)
  Anyolite.wrap(rb, SF::Music, under: SF, verbose: true, connect_to_superclass: true)
end
