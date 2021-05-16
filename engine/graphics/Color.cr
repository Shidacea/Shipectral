module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::SpecializeInstanceMethod("initialize", [red : UInt8, green : UInt8, blue : UInt8, alpha : UInt8? = nil])]
  @[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
  struct Color
    def initialize(red : UInt8, green : UInt8, blue : UInt8, alpha : UInt8? = nil)
      @r = uninitialized UInt8
      @g = uninitialized UInt8
      @b = uninitialized UInt8
      @a = uninitialized UInt8

      puts "#{red} #{green} #{blue} #{alpha}"
      SFMLExt.sfml_color_initialize_9yU9yU9yU9yU(to_unsafe, UInt8.new(red), UInt8.new(green), UInt8.new(blue), UInt8.new(alpha ? alpha : 255))
    end
  end
end

def setup_ruby_color_class(rb)
  Anyolite.wrap(rb, SF::Color, under: SF, verbose: true, wrap_superclass: false)
end
