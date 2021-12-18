class TestEntity < SDC::Entity
	register_id(:TestEntity)

	add_shape(index: 0, type: SF::CollisionShapeCircle, radius: 25.0)
	add_box(index: 0, size: SDC.xy(50.0, 50.0), offset: SDC.xy(0.0, 0.0), origin: SDC.xy(25.0, 25.0))

	SDC::Data.load_texture(:EntityChishi, filename: "assets/graphics/test/Chishi.png")

	add_sprite(index: 0, texture_index: :EntityChishi, offset: SDC.xy(0.0, 0.0), rect: SF::IntRect.new(0, 0, 50, 50), origin: SDC.xy(25.0, 25.0))

	set_hitshape(index: 7, shape_index: 0, damage: 3, attributes: {:test => 3})
	set_hurtshape(index: 13, shape_index: 0)

	self.living = true
	self.gravity_multiplier = 2.0
	self.ai_active = true
	self.max_hp = 10

	def at_init
		self.max_hp += 20
		self.hitshapes[7].damage += 1
		self.hitshapes[7].attributes[:test] = 5

		full_heal
	end

	def custom_update

	end

	def at_entity_collision(other_entity, hurtshape, hitshape)
		
	end

	def custom_physics
		# Debug floor
		if @position.y > 500.0 then
			@position.y = 500.0
			@velocity.y = 0.0
		end
	end

	def master_ai_script
		SDC::AI.forever do

			if collided_with_class(TestEntity) then
				SDC.set_switch("coll")
			end

		end
	end

	def ai_script
		SDC::AI.forever do
		
			if SDC.get_switch("test") && SDC.key_pressed?(:Q) then
				@velocity.y -= SDC.get_variable("test", default: 1000.0 * (SDC.game.meter / SDC.game.second**2)) * rand
				SDC::AI.wait(10)
			end

		end
	end

end