module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  module Keyboard
    enum Key
      {% for element in Rl::KeyboardKey.constants %}
        {{element}} = Rl::KeyboardKey::{{element}}
      {% end %}
    end

    def self.key_pressed?(key : Key)
      Rl.key_pressed?(key.to_i32)
    end

    def self.key_down?(key : Key)
      Rl.key_down?(key.to_i32)
    end

    def self.key_up?(key : Key)
      Rl.key_up?(key.to_i32)
    end

    def self.key_released?(key : Key)
      Rl.key_released?(key.to_i32)
    end
  end
end