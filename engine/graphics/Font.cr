module SF
  @[Anyolite::ExcludeInstanceMethod("load_from_stream")]
  @[Anyolite::ExcludeInstanceMethod("load_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_file")]
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::ExcludeClassMethod("from_file")]
  @[Anyolite::ExcludeClassMethod("from_memory")]
  @[Anyolite::ExcludeClassMethod("from_stream")]
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Font
    @[Anyolite::Rename("load_from_file")]
    def load_from_sdc_path(filename : String)
      load_from_file(SDC::Script.get_full_filename(filename))
    end

    @[Anyolite::ExcludeInstanceMethod("inspect")]
    @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
    @[Anyolite::ExcludeConstant("Reference")]
    class Info
    end
  end
end

def setup_ruby_font_class(rb)
  Anyolite.wrap(rb, SF::Font, under: SF, verbose: true, connect_to_superclass: false)
end
