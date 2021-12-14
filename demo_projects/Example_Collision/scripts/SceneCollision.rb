class SceneCollision < SDC::Scene 

	def handle_event(event)
		@dragged_object = nil unless SDC.window.has_focus?

		if event.has_type?(:Closed) then
			SDC.next_scene = nil

		elsif event.has_type?(:MouseButtonPressed) then
			if !@dragged_object then
				found = nil
				@shapes.each do |shape|
					if SDC.mouse_touching?(shape.collision_shape, offset: shape.pos) then
						if !found || shape.z > found.z then
							found = shape
						end
					end
					if found then
						@dragged_object = [found, SDC.get_mouse_coords - found.pos]
					end
				end
			end

		elsif event.has_type?(:MouseButtonReleased) then
			@dragged_object = nil

		elsif event.has_type?(:MouseWheelScrolled) then
			if @dragged_object then
				if event.mouse_scrolled_up? then
					@dragged_object[0].collision_shape.scale *= 1.1
					@dragged_object[0].update
				elsif event.mouse_scrolled_down? then
					@dragged_object[0].collision_shape.scale *= (1.0 / 1.1)
					@dragged_object[0].update
				end
			end

		elsif event.has_type?(:KeyPressed) then
			if @dragged_object && @dragged_object[0].collision_shape.is_a?(SF::CollisionShapeBox) then
				if event.key_pressed?(:Down) then
					@dragged_object[0].collision_shape.size = SDC.xy(@dragged_object[0].collision_shape.size.x, @dragged_object[0].collision_shape.size.y * 1.1)
					@dragged_object[0].update
				elsif event.key_pressed?(:Up) then
					@dragged_object[0].collision_shape.size = SDC.xy(@dragged_object[0].collision_shape.size.x, @dragged_object[0].collision_shape.size.y * (1.0 / 1.1))
					@dragged_object[0].update
				elsif event.key_pressed?(:Right) then
					@dragged_object[0].collision_shape.size = SDC.xy(@dragged_object[0].collision_shape.size.x * 1.1, @dragged_object[0].collision_shape.size.y)
					@dragged_object[0].update
				elsif event.key_pressed?(:Left) then
					@dragged_object[0].collision_shape.size = SDC.xy(@dragged_object[0].collision_shape.size.x * (1.0 / 1.1), @dragged_object[0].collision_shape.size.y)
					@dragged_object[0].update
				end
			end

			if @dragged_object then
				if event.key_pressed?(:A) then
					@dragged_object[0].collision_shape.offset += SDC.xy(-10.0, 0.0)
					@dragged_object[0].update
				elsif event.key_pressed?(:D) then
					@dragged_object[0].collision_shape.offset += SDC.xy(10.0, 0.0)
					@dragged_object[0].update
				elsif event.key_pressed?(:W) then
					@dragged_object[0].collision_shape.offset += SDC.xy(0.0, -10.0)
					@dragged_object[0].update
				elsif event.key_pressed?(:S) then
					@dragged_object[0].collision_shape.offset += SDC.xy(0.0, 10.0)
					@dragged_object[0].update
				elsif event.key_pressed?(:E) then
					@dragged_object[0].collision_shape.scale *= 1.1
					@dragged_object[0].update
				elsif event.key_pressed?(:Q) then
					@dragged_object[0].collision_shape.scale *= (1.0 / 1.1)
					@dragged_object[0].update
				end
			end

		end
	end

	def at_init
		@shapes = []
		@z = 0
		@counter = 0
		
		@indicator = SF::DrawShapeCircle.new
		@indicator.radius = 10
		@indicator.outline_thickness = 2.0
		@indicator.outline_color = SF::Color.new(255, 0, 0, 255)
		@indicator.fill_color = SF::Color.new(0, 0, 0, 0)

		@draw_indicator = false

		@new_obj_x = 400
		@new_obj_y = 400

		@new_circle_r = 100
		
		@new_box_w = 300
		@new_box_h = 200

		@new_side_1_x = 100
		@new_side_1_y = 100
		@new_side_2_x = 50
		@new_side_2_y = -50

		@marked = nil

		@dragged_object = nil
	end

	def update
		@draw_indicator = false

		if @dragged_object then
			@dragged_object[0].pos = SDC.get_mouse_coords - @dragged_object[1]
		end

		0.upto(@shapes.size - 1) do |i|
			(i + 1).upto(@shapes.size - 1) do |j|
				first_shape = @shapes[i]
				second_shape = @shapes[j]

				if SF::Collider.test(first_shape.collision_shape, first_shape.pos, second_shape.collision_shape, second_shape.pos) then
					@draw_indicator = true
				end
			end
		end
	end

	def draw
		@shapes.each do |shape|
			shape.draw
		end
		SDC.window.draw_translated(@indicator, 1000000, SDC.xy(15, 15)) if @draw_indicator
	end

	def draw_imgui
		SF::ImGui.begin "Shapes" do
			SF::ImGui.input_instance_variable_int("x", self, :@new_obj_x)
			SF::ImGui.input_instance_variable_int("y", self, :@new_obj_y)

			SF::ImGui.input_instance_variable_int("Radius", self, :@new_circle_r)

			SF::ImGui.button "New circle" do
				@shapes.push TestShape.new_circle(pos: SDC.xy(@new_obj_x, @new_obj_y), radius: @new_circle_r, z: @z, counter: @counter)

				@z += 0.1
				@counter += 1
			end

			SF::ImGui.input_instance_variable_int("Box width", self, :@new_box_w)
			SF::ImGui.input_instance_variable_int("Box height", self, :@new_box_h)

			SF::ImGui.button "New box" do
				@shapes.push TestShape.new_box(pos: SDC.xy(@new_obj_x, @new_obj_y), size: SDC.xy(@new_box_w, @new_box_h), z: @z, counter: @counter)

				@z += 0.1
				@counter += 1
			end

			SF::ImGui.input_instance_variable_int("Triangle side 1 x", self, :@new_side_1_x)
			SF::ImGui.input_instance_variable_int("Triangle side 1 y", self, :@new_side_1_y)
			SF::ImGui.input_instance_variable_int("Triangle side 2 x", self, :@new_side_2_x)
			SF::ImGui.input_instance_variable_int("Triangle side 2 y", self, :@new_side_2_y)

			SF::ImGui.button "New triangle" do
				@shapes.push TestShape.new_triangle(pos: SDC.xy(@new_obj_x, @new_obj_y), 
					side_1: SDC.xy(@new_side_1_x, @new_side_1_y),
					side_2: SDC.xy(@new_side_2_x, @new_side_2_y), z: @z, counter: @counter)

				@z += 0.1
				@counter += 1
			end
		end
	end

end