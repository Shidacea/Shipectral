module SF
  module Keyboard
    @[Anyolite::SpecializeClassMethod("parse?", [string], [string : String])]
    enum Key
      @[Anyolite::WrapWithoutKeywords]
      @[Anyolite::Rename("==")]
      def same_as?(other : Key)
        self == other  
      end
    end
  end
end

def setup_ruby_keyboard_class(rb)
  Anyolite.wrap(rb, SF::Keyboard, under: SF, verbose: true, wrap_superclass: false)
end
