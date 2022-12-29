module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::SpecifyGenericTypes([T])]
  class HookHandler(T)
    getter hooks : Hash(String, SDC::AI::RubyScript(T)) = {} of String => SDC::AI::RubyScript(T)
    getter current_hook : String? = nil
    property next_hook : String? = nil

    @[Anyolite::Exclude]
    def trigger_hook(obj : T, name : String)
      SDC.error "Hook #{@current_hook} is already active. Use \"switch_to_hook\" instead of \"trigger_hook\"." if @current_hook
      @next_hook = nil

      if @hooks[name]?
        @current_hook = name
        @hooks[name].tick(obj)
        @current_hook = nil
      end

      next_hook_name = @next_hook
      @next_hook = nil

      trigger_hook(obj, next_hook_name.not_nil!) if next_hook_name
    end

    @[Anyolite::Exclude]
    def add_hooks(hooks : Hash(String, SDC::AI::RubyScript(T)))
      @hooks.merge!(hooks)
    end
  end

  alias HookHandlerEntity = HookHandler(SDC::Entity)
  alias HookHandlerScene = HookHandler(SDC::Scene)
end