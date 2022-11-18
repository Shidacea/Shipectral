module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Entity
    getter param : SDC::Param
    getter parent : SDC::Entity?
    getter children : Array(SDC::Entity) = [] of SDC::Entity
    getter last_collisions : Array(SDC::Entity) = [] of SDC::Entity
    getter in_ruby : Bool = false
    getter magic_number : UInt64 = 0

    getter data : SDC::EntityData
    getter hooks : Hash(String, SDC::AI::RubyScript) = {} of String => SDC::AI::RubyScript
    getter current_hook : String? = nil
  
    property next_hook : String? = nil
    property state : SDC::EntityState = SDC::EntityState.new

    property position : SDC::Coords = SDC.xy
    property velocity : SDC::Coords = SDC.xy
    property acceleration : SDC::Coords = SDC.xy

    macro call_method(name, *args)
      if @in_ruby
        {% if args.empty? %}
          Anyolite.call_rb_method({{name}})
        {% else %}
          Anyolite.call_rb_method({{name}}, args: [{{*args}}])
        {% end %}
      else
        {{name.id}}({{*args}})
      end
    end

    def self.spawn(data : SDC::EntityData, param : SDC::Param = SDC::Param.new(nil))
      new_entity = self.new(data, param)
      new_entity.init
      new_entity
    end

    @[Anyolite::WrapWithoutKeywords]
    def initialize(@data : SDC::EntityData, @param : SDC::Param = SDC::Param.new(nil))
      @hooks = @data.copy_hooks

      initialization_procedure
    end

    def init
      trigger_hook("spawn")
    end

    def trigger_hook(name : String)
      SDC.error "Hook #{@current_hook} is already active. Use \"switch_to_hook\" instead of \"trigger_hook\"." if @current_hook
      @next_hook = nil

      if @hooks[name]?
        @current_hook = name
        @hooks[name].tick(self)
        @current_hook = nil
      end

      next_hook_name = @next_hook
      @next_hook = nil

      trigger_hook(next_hook_name.not_nil!) if next_hook_name
    end

    def update
      call_method(:custom_update)
      trigger_hook("update")
    end

    def draw
      call_method(:custom_draw)
      trigger_hook("draw")
    end

    def rb_initialize(rb)
      @in_ruby = true
    end

    def initialization_procedure
			# Set a magic number to identify parent-child-structures
			@magic_number = self.object_id

			# load_boxes
			# load_shapes
			# load_sprites
			# load_hitshapes
			# load_hurtshapes

			# if self.living
			# 	full_heal
			# 	@invincibility_frame_counter = 0
			# 	@invincibility_next_frame = false
			# end
		end

    def custom_update

		end

		def custom_draw

		end
  end
end