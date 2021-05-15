module SF
  @[Anyolite::ExcludeInstanceMethod("open_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("open_from_file")]
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::ExcludeInstanceMethod("loop_points")]
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::SpecializeInstanceMethod("loop_points=", [time_points : PseudoTimeSpan])]
  @[Anyolite::ExcludeClassMethod("from_file")]
  @[Anyolite::ExcludeClassMethod("from_memory")]
  @[Anyolite::ExcludeClassMethod("from_stream")]
  @[Anyolite::ExcludeConstant("Span")]
  @[Anyolite::ExcludeConstant("TimeSpan")]
  class Music
    @[Anyolite::Rename("open_from_file")]
    @[Anyolite::WrapWithoutKeywords]
    def load_from_sdc_path(filename : String)
      open_from_file(ScriptHelper.path + "/" + filename)
    end

    def loop_points=(time_points : PseudoTimeSpan)
      SFMLExt.sfml_music_setlooppoints_TU3(to_unsafe, time_points)
    end

    @[Anyolite::Rename("loop_points")]
    def pseudo_loop_points
      result = Music::PseudoTimeSpan.allocate
      SFMLExt.sfml_music_getlooppoints(to_unsafe, result)
      return result
    end

    @[Anyolite::RenameClass("TimeSpan")]
    struct PseudoTimeSpan
      property offset : Time 
      property length : Time

      def initialize(@offset : Time = SF::Time.new, @length : Time = SF::Time.new)
      end

      def to_unsafe 
        pointerof(@offset).as(Void*)
      end
    end
  end
end

def setup_ruby_music_class(rb)
  Anyolite.wrap(rb, SF::Music, under: SF, verbose: true, wrap_superclass: false)
end
