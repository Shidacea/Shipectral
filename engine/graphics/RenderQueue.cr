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

  def <(other)
    @z < other.z
  end
end

class RenderQueue
  MAX_Z_GROUP = 16
  MAX_ELEMENTS_PER_GROUP = 4096

  @queue : Array(Array(RenderCall)) = Array(Array(RenderCall)).new(initial_capacity: MAX_Z_GROUP)
  @element_count : Array(UInt64) = Array(UInt64).new(MAX_Z_GROUP, 0)
  @max_z_used : UInt64 = 0

  @invalid : Bool = false

  def initialize
    0.upto(MAX_Z_GROUP - 1) do |z_group|
      @queue[z_group] = Array(RenderCall).new(initial_capacity: MAX_ELEMENTS_PER_GROUP)
    end
  end

  def get_z_group(z : Float)
    return_value : UInt64 = 0

    if z >= 0.0
      int_z = z.to_i
      return_value = (int_z >= MAX_Z_GROUP - 1) ? MAX_Z_GROUP - 1 : int_z + 1
    end

    @max_z_used = return_value if return_value > @max_z_used

    return_value
  end

  def push(obj : SF::Drawable, states : SF::RenderStates, view : SF::View, origin : SF::Vector2f, position : SF::Vector2f, scale : SF::Vector2f, rotation : Float, z : Float)
    z_group = get_z_group(z)

    if @element_count[z_group] >= MAX_ELEMENTS_PER_GROUP
      @invalid = true
      return
    else
      @queue[z_group][(@element_count[z_group] += 1)] = RenderCall.new(obj, states, view, origin, position, scale, rotation, z)
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
    0.upto(MAX_Z_GROUP - 1) do |z|
      sort(z)

      0.upto(@element_count[z] - 1) do |i|
        render_call = get_render_call(z, i)

        t_obj = render_call.obj.as(SF::Transformable)

        t_obj.origin = render_call.origin
        t_obj.position = render_call.position
        t_obj.scale = render_call.scale
        t_obj.rotation = render_call.rotation

        old_view = window.view
        window.view = render_call.view
        window.draw(render_call.obj, render_call.states)
        window.view = old_view
      end
    end
  end
end