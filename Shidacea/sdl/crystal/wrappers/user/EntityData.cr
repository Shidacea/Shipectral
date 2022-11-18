module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class EntityData
    getter hooks : Hash(String, SDC::AI::RubyScriptTemplatePage) = {} of String => SDC::AI::RubyScriptTemplatePage
    getter properties : Hash(String, SDC::Param) = {} of String => SDC::Param
  
    def set_property(name : String, value : SDC::Param)
      @properties[name] = value
    end

    def add_hook(name : String, script : SDC::AI::RubyScriptTemplatePage)
      @hooks[name] = script
    end

    def copy_hooks
      @hooks.transform_values do |value|
        SDC::AI::RubyScript.new(value)
      end
    end
  end
end