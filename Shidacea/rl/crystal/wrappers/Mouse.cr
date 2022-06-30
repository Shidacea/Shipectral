module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  module Mouse
    enum Button
      {% for element in Rl::MouseButton.constants %}
        {{element}} = Rl::MouseButton::{{element}}
      {% end %}
    end

    def self.button_pressed?(button : Button)
      Rl.mouse_button_pressed?(button.to_i32)
    end

    def self.button_down?(button : Button)
      Rl.mouse_button_down?(button.to_i32)
    end

    def self.button_up?(button : Button)
      Rl.mouse_button_up?(button.to_i32)
    end

    def self.button_released?(button : Button)
      Rl.mouse_button_released?(button.to_i32)
    end

    def self.x
      Rl.get_mouse_x
    end

    def self.x=(value : Int)
      Rl.set_mouse_position(value, self.y)
    end

    def self.y
      Rl.get_mouse_y
    end

    def self.y=(value : Int)
      Rl.set_mouse_position(self.x, value)
    end

    def self.position 
      Rl.get_mouse_position
    end

    def self.position=(value : Rl::Vector2)
      Rl.set_mouse_position(value.x, value.y)
    end
  end
end