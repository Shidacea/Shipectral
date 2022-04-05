require "imgui"
require "imgui-sfml"

require "./imgui/ImGui.cr"

SPT::Features.add("imgui")

def load_imgui_wrappers(rb)
  setup_ruby_imgui_module(rb)
end