module SF
  @[Anyolite::ExcludeInstanceMethod("inspect")]
  @[Anyolite::ExcludeInstanceMethod("load_from_file")]
  @[Anyolite::ExcludeInstanceMethod("load_from_memory")]
  @[Anyolite::ExcludeInstanceMethod("load_from_stream")]
  @[Anyolite::SpecializeInstanceMethod("initialize", nil)]
  @[Anyolite::SpecializeInstanceMethod("update", [texture : Texture])]
  @[Anyolite::SpecializeInstanceMethod("load_from_image", [image : Image, area : IntRect = IntRect.new], [image : Image, area : IntRect = SF::IntRect.new])]
  @[Anyolite::ExcludeClassMethod("bind")]
  @[Anyolite::ExcludeClassMethod("from_file")]
  @[Anyolite::ExcludeClassMethod("from_memory")]
  @[Anyolite::ExcludeClassMethod("from_stream")]
  @[Anyolite::ExcludeClassMethod("from_image")]
  @[Anyolite::ExcludeConstant("Reference")]
  class Texture
    def load_from_sdc_path(filename : String, texture_rect : IntRect)
      load_from_file(ScriptHelper.path + "/" + filename, texture_rect)
    end
  end
end

def setup_ruby_texture_class(rb)
  Anyolite.wrap(rb, SF::Texture, under: SF, verbose: true, wrap_superclass: false)
end
