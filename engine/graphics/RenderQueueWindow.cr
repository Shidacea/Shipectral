require "./RenderQueue.cr"

class RenderQueueWindow
  @window = uninitialized SF::RenderWindow
  @render_queue : RenderQueue = RenderQueue.new
  @clock : SF::Clock = SF::Clock.new

  def initialize
  end

  def draw_object(render_states : SF::RenderStates, draw_object : SF::Drawable, z : Float)
    t_obj = draw_object.as(Transformable)

    origin = t_obj.origin
    position = t_obj.position
    scale = t_obj.scale
    rotation = t_obj.rotation

    @render_queue.push(draw_object, render_states, @window.view, origin, position, scale, rotation, z)

    if @render_queue.invalid
      Anyolite.raise_runtime_error("Maximum render queue level of #{RenderQueue::MAX_ELEMENTS_PER_GROUP} reached at z group #{@render_queue.get_z_group(z)} for z = #{@z}.")
    end
  end

  def init(mode : SF::VideoMode, title : String, style : SF::Style, settings : SF::ContextSettings)
    @window = SF::RenderWindow.new(mode, title, style, settings)
  end

  def imgui_defined?
    false # TODO
  end

  def width
    @window.size.x
  end

  def height
    @window.size.y
  end

  def clear
    @window.clear
  end

  def display
    @window.display
  end

  def is_open?
    @window.open?
  end

  def has_focus?
    @window.has_focus?
  end

  def visible=(value : Bool)
    @window.visible = value
  end

  def vsync=(value : Bool)
    @window.vertical_sync_enabled = value
  end

  def set_view(view : SF::View)
    @window.view = view
  end

  def get_view
    @window.view
  end

  def poll_event(event : SF::Event)
    @window.poll_event
  end

  def close
    @window.close
  end

  def render
    @render_queue.draw_to(@window)
  end

  def get_window_reference
    @window
  end

  def render_and_display
    render
    display
  end
end