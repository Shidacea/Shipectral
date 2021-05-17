module SF
  @[Anyolite::SpecializeClassMethod("position=", [position : Vector2 | Tuple], [position : Vector2i])]
  @[Anyolite::SpecializeClassMethod("set_position", [position : Vector2 | Tuple, relative_to : Window], [position : Vector2i, relative_to : Window])]
  module Mouse
    @[Anyolite::SpecializeClassMethod("parse?", [string], [string : String])]
    enum Button
      @[Anyolite::WrapWithoutKeywords]
      @[Anyolite::Rename("==")]
      def same_as?(other : Button)
        self == other  
      end
    end

    @[Anyolite::SpecializeClassMethod("parse?", [string], [string : String])]
    enum Wheel
      @[Anyolite::WrapWithoutKeywords]
      @[Anyolite::Rename("==")]
      def same_as?(other : Wheel)
        self == other  
      end
    end
  end
end

def setup_ruby_mouse_class(rb)
  Anyolite.wrap(rb, SF::Mouse, under: SF, verbose: true, wrap_superclass: false)
end
