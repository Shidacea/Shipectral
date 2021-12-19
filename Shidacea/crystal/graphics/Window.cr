require "./RenderQueue.cr"

module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class GameWindow
    @window : SF::RenderWindow
    @render_queue : RenderQueue = RenderQueue.new
    @clock : SF::Clock = SF::Clock.new

    def initialize(title : String, width : UInt32, height : UInt32, fullscreen : Bool = false)
      if fullscreen
        @window = SF::RenderWindow.new(SF::VideoMode.new(width, height), title, SF::Style::Fullscreen)
      else
        @window = SF::RenderWindow.new(SF::VideoMode.new(width, height), title)
      end

      imgui_init
    end

    @[Anyolite::AddBlockArg(1, Nil)]
    def use_view(view : SF::View)
      old_view = @window.view.dup
      @window.view = view
      yield nil
      @window.view = old_view
    end

    @[Anyolite::Exclude]
    def draw_object(render_states : SF::RenderStates, draw_object : SF::Drawable, z : Float32)
      t_obj = draw_object.as(SF::Transformable)

      origin = t_obj.origin
      position = t_obj.position
      scale = t_obj.scale
      rotation = t_obj.rotation

      @render_queue.push(draw_object, render_states, @window.view.dup, origin, position, scale, rotation, z)

      if @render_queue.invalid
        Anyolite.raise_runtime_error("Maximum render queue level of #{RenderQueue::MAX_ELEMENTS_PER_GROUP} reached at z group #{@render_queue.get_z_group(z)} for z = #{z}.\nDiagnose: #{@render_queue.diagnose}")
      end

      true
    end

    def draw_translated(draw_object : SF::Sprite | SF::Text | SF::Shape | SF::Transformable | SDC::MapLayer, z : Float32 = 0.0f32, at : SF::Vector2f = SF::Vector2f.new, render_states : SF::RenderStates = SF::RenderStates.new)
      actual_render_states = render_states

      transform = SF::Transform.new
      transform.translate(at)
      actual_render_states.transform *= transform

      draw_object(actual_render_states, draw_object.as(SF::Drawable), z)

      true
    end

    def draw(draw_object : SF::Sprite | SF::Text | SF::Shape | SF::Transformable | SDC::MapLayer, z : Float32 = 0.0f32, render_states : SF::RenderStates = SF::RenderStates.new)
      draw_object(render_states, draw_object.as(SF::Drawable), z)
    end

    def imgui_defined?
      true # TODO
    end

    def set_imgui_scale(value : Float32)
      # TODO  
    end

    def imgui_init
      ImGui::SFML.init(@window)
    end

    def imgui_render
      ImGui::SFML.render(@window)
    end

    def imgui_update
      ImGui::SFML.update(@window, @clock.restart)
    end

    def imgui_process_event(event : SF::Event)
      ImGui::SFML.process_event(@window, event)
    end

    def imgui_shutdown
      ImGui::SFML.shutdown
    end

    def width
      @window.size.x
    end

    def height
      @window.size.y
    end

    def clear
      @window.clear
      true
    end

    def display
      @window.display
      true
    end

    def is_open?
      @window.open?
    end

    def has_focus?
      @window.focus?
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

    def poll_event
      if event = @window.poll_event
        imgui_process_event(event)
        event
      else
        nil
      end
    end

    def close
      @window.close
      imgui_shutdown
    end

    def render
      @render_queue.draw_to(@window)
    end

    @[Anyolite::Exclude]
    def get_window_reference
      @window
    end

    def map_pixel_to_coords(point : SF::Vector2i)
      get_window_reference.map_pixel_to_coords(point)
    end

    def map_coords_to_pixel(point : SF::Vector2i)
      get_window_reference.map_coords_to_pixel(point)
    end

    def render_and_display
      render
      imgui_render
      display
    end
  end
end

def setup_ruby_window_class(rb)
  Anyolite.wrap(rb, SDC::GameWindow, under: SDC, verbose: true, connect_to_superclass: false)
end