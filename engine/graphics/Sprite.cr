module SF
    struct Vector2(T)
        def object_id
            0.to_u64
        end
    end

    struct Rect(T)
        def object_id
            0.to_u64
        end
    end

    class Sprite
        def link_texture(new_texture)
            texture = new_texture
        end
    end
end

def setup_ruby_sprite_class(mrb, module_sdc)
    MrbWrap.wrap_class(mrb, SF::Sprite, "Sprite", under: module_sdc)
    MrbWrap.wrap_constructor(mrb, SF::Sprite)
    MrbWrap.wrap_instance_method(mrb, SF::Sprite, "link_texture", link_texture, SF::Texture)
    MrbWrap.wrap_property(mrb, SF::Sprite, "position", position, SF::Vector2f)
    MrbWrap.wrap_property(mrb, SF::Sprite, "scale", scale, SF::Vector2f)
    MrbWrap.wrap_property(mrb, SF::Sprite, "texture_rect", texture_rect, SF::IntRect)
    MrbWrap.wrap_instance_method(mrb, SF::Sprite, "move", move, [SF::Vector2f])
    MrbWrap.wrap_property(mrb, SF::Sprite, "rotation", rotation, Float32)   # TODO: Ensure specific data types according to SFML and mruby here
    MrbWrap.wrap_property(mrb, SF::Sprite, "origin", origin, SF::Vector2f)
    MrbWrap.wrap_property(mrb, SF::Sprite, "color", color, SF::Color)
end