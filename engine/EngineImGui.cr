require "imgui"
require "imgui-sfml"

require "./imgui/ImGui.cr"

def load_imgui_wrappers(rb)
  setup_ruby_imgui_module(rb)
  
  SPT::Features.add("imgui")
end