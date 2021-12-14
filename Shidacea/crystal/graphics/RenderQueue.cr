module SDC
  struct RenderCall
    property obj : SF::Drawable? = nil
    property states : SF::RenderStates
    property view : SF::View

    property origin : SF::Vector2f
    property position : SF::Vector2f
    property scale : SF::Vector2f
    property rotation : Float32 = 0.0

    property z : Float32 = 0.0
    
    def initialize(@obj, @states, @view, @origin, @position, @scale, @rotation, @z)
    end

    def <=>(other)
      @z <=> other.z
    end
  end

  class RenderQueue
    MAX_Z_GROUP = 16
    MAX_ELEMENTS_PER_GROUP = 4096

    @queue : Array(Array(RenderCall)) = Array(Array(RenderCall)).new(initial_capacity: MAX_Z_GROUP)
    @element_count : Array(UInt64) = Array(UInt64).new(MAX_Z_GROUP, 0)
    @max_z_used : UInt64 = 0

    property invalid : Bool = false

    def initialize
      0.upto(MAX_Z_GROUP - 1) do |z_group|
        @queue.push Array(RenderCall).new(initial_capacity: MAX_ELEMENTS_PER_GROUP)
      end
    end

    def diagnose
      "Render queue element counts: #{@element_count.inspect}"
    end

    def get_z_group(z : Float32)
      return_value = 0

      if z >= 0.0
        int_z = z.to_i
        return_value = (int_z >= MAX_Z_GROUP - 1) ? MAX_Z_GROUP - 1 : int_z + 1
      end

      @max_z_used = return_value.to_u64 if return_value > @max_z_used

      return_value.to_u64
    end

    def push(obj : SF::Drawable, states : SF::RenderStates, view : SF::View, origin : SF::Vector2f, position : SF::Vector2f, scale : SF::Vector2f, rotation : Float, z : Float32)
      z_group = get_z_group(z)

      if @element_count[z_group] >= MAX_ELEMENTS_PER_GROUP
        @invalid = true
        return
      else
        @element_count[z_group] += 1
        @queue[z_group].push RenderCall.new(obj, states, view, origin, position, scale, rotation, z)
      end
    end

    def sort(z_group : UInt64)
      if @element_count[z_group] > 1
        @queue[z_group].sort!
      end
    end

    def reset(z_group : UInt64)
      @element_count[z_group] = 0
      @queue[z_group].clear
    end

    def get_render_call(z_group : UInt64, element : UInt64)
      return @queue[z_group][element]
    end

    def draw_to(window : SF::RenderWindow)
      0u64.upto(@max_z_used) do |z|
        sort(z)

        if @element_count[z] > 0
          0u64.upto(@element_count[z] - 1) do |i|
            render_call = get_render_call(z, i)

            if d_obj = render_call.obj
              t_obj = d_obj.as(SF::Transformable)

              old_origin = t_obj.origin
              old_position = t_obj.position
              old_scale = t_obj.scale
              old_rotation = t_obj.rotation

              t_obj.origin = render_call.origin
              t_obj.position = render_call.position
              t_obj.scale = render_call.scale
              t_obj.rotation = render_call.rotation

              old_view = window.view.dup
              window.view = render_call.view
              window.draw(d_obj, render_call.states)
              window.view = old_view

              # TODO: Is there a better way than just setting and resetting everything?

              t_obj.origin = old_origin
              t_obj.position = old_position
              t_obj.scale = old_scale
              t_obj.rotation = old_rotation
            end
          end
        end

        reset(z)
      end
    end
  end
end