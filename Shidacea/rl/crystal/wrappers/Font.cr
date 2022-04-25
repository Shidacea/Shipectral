@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::SpecializeInstanceMethod("base_size=", [value], [value : Int32])]
@[Anyolite::SpecializeInstanceMethod("glyph_count=", [value], [value : Int32])]
@[Anyolite::SpecializeInstanceMethod("glyph_padding=", [value], [value : Int32])]
@[Anyolite::SpecializeInstanceMethod("texture=", [value], [value : Rl::Texture])]
@[Anyolite::ExcludeInstanceMethod("recs=")]
@[Anyolite::ExcludeInstanceMethod("glyphs=")]
struct Rl::Font
  def self.load_from_file(filename : String)
    Rl.load_font(filename)
  end
end