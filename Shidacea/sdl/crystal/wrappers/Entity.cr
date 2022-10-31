module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Entity
    getter param : SDC::Param
    getter parent : SDC::Entity?
    getter children : Array(SDC::Entity) = [] of SDC::Entity
    getter last_collisions : Array(SDC::Entity) = [] of SDC::Entity
    getter in_ruby : Bool = false
    getter magic_number : UInt64 = 0

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

    @[Anyolite::WrapWithoutKeywords]
    def initialize(@param : SDC::Param = SDC::Param.new(nil))
      initialization_procedure
    end

    def update
      call_method(:custom_update)
    end

    def draw
      call_method(:custom_draw)
    end

    def rb_initialize(rb)
      @in_ruby = true
    end

    def initialization_procedure
			# setup_ai

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