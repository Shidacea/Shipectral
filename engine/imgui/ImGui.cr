@[Anyolite::RenameModule("ImGui")]
module ImGuiHelper
  @[Anyolite::AddBlockArg(1, Nil)]
  @[Anyolite::WrapWithoutKeywords]
  def self.begin(name : String)
    ImGui.begin(name)
    yield nil
    ImGui.end
  end

  @[Anyolite::StoreBlockArg]
  @[Anyolite::WrapWithoutKeywords]
  def self.button(name : String)
    return_value = ImGui.button(name)
    ruby_block = Anyolite.obtain_given_rb_block
    if ruby_block
      Anyolite.call_rb_block(ruby_block, nil)
    end
    return_value
  end

  @[Anyolite::WrapWithoutKeywords]
  def self.text(value : String)
    ImGui.text_unformatted(value)
  end

  @[Anyolite::AddBlockArg(1, Nil)]
  @[Anyolite::WrapWithoutKeywords]
  def self.begin_child(name : String)
    ImGui.begin_child(name)
    yield nil
    ImGui.end_child
  end

  def self.same_line
    ImGui.same_line
  end

  def self.new_line
    ImGui.new_line
  end
end

def setup_ruby_imgui_module(rb)
  Anyolite.wrap(rb, ImGuiHelper, under: SF, verbose: true)
end
