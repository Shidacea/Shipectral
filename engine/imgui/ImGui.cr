@[Anyolite::RenameModule("ImGui")]
@[Anyolite::DefaultOptionalArgsToKeywordArgs]
module ImGuiHelper
  @[Anyolite::AddBlockArg(1, Nil)]
  def self.begin(name : String)
    ImGui.begin(name)
    yield nil
    ImGui.end
  end

  @[Anyolite::StoreBlockArg]
  def self.button(name : String)
    return_value = ImGui.button(name)
    ruby_block = Anyolite.obtain_given_rb_block

    if ruby_block && return_value
      Anyolite.call_rb_block(ruby_block, nil)
    end

    return_value
  end

  def self.text(value : String)
    ImGui.text_unformatted(value)
  end

  @[Anyolite::AddBlockArg(1, Nil)]
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

  # TODO: Rework the whole input model in the next version
  def self.input_instance_variable_int(label : String, obj : Anyolite::RbRef, sym : Anyolite::RbRef)
    nil
  end

  def self.input_instance_variable_string(label : String, obj : Anyolite::RbRef, sym : Anyolite::RbRef)
    nil
  end

  def self.input_int(label : String, objs : Array(Int32))
    nil
  end
end

def setup_ruby_imgui_module(rb)
  Anyolite.wrap(rb, ImGuiHelper, verbose: true)
end
