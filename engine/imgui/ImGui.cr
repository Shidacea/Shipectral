@[Anyolite::RenameModule("ImGui")]
module ImGuiHelper
  @[Anyolite::AddBlockArg(1, Nil)]
  @[Anyolite::WrapWithoutKeywords]
  def self.begin(name : String)
    ImGui.begin(name)
    yield nil
    ImGui.end
  end

  @[Anyolite::AddBlockArg(1, Nil)]
  @[Anyolite::WrapWithoutKeywords]
  def self.button(name : String)
    return_value = ImGui.button(name)
    yield nil if return_value
    return_value
  end
end

def setup_ruby_imgui_module(rb)
  Anyolite.wrap(rb, ImGuiHelper, under: SF, verbose: true)
end
