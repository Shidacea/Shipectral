module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::SpecifyGenericTypes([T])]
  class HookHandler(T)
    getter hooks : Hash(String, SDC::AI::RubyScript(T)) = {} of String => SDC::AI::RubyScript(T)
    getter current_hook : String? = nil
    property next_hook : String? = nil

    @stack : Deque(String) = Deque(String).new(initial_capacity: 5)

    @[Anyolite::Exclude]
    def trigger_hook(obj : T, name : String)
      SDC.error "Hook #{@current_hook} is already active. Use \"switch_to_hook\" instead of \"trigger_hook\"." if @current_hook
      @next_hook = nil

      if @hooks[name]?
        @current_hook = name
        running = @hooks[name].tick(obj)
        @current_hook = nil
      end

      next_hook_name = @next_hook
      @next_hook = nil

      if next_hook_name
        @stack.push name
        trigger_hook(obj, next_hook_name.not_nil!)
      end

      unless @stack.empty?
        trigger_hook(obj, @stack.pop)
      end
    end

    @[Anyolite::Exclude]
    def add_hooks(hooks : Hash(String, SDC::AI::RubyScript(T)))
      @hooks.merge!(hooks)
    end
  end

  alias HookHandlerEntity = HookHandler(SDC::Entity)
  alias HookHandlerScene = HookHandler(SDC::Scene)
end