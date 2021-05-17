class SceneTest < SDC::Scene 

	def handle_event(event)
		if event.has_type?(:Closed) then
			SDC.next_scene = nil

		elsif SDC.text_input then
			SDC.process_text_input(event: event, text_buffer: @text_buffer) do |char, text|

				# Your letter 'T' works fine, but this code does change it sometimes ;-)
				# Filters can do various things, this is just an example
				# You can also use the :override option to completely define your own routines!

				if char == "T" && Time.now.monday? then
					next "t"
				else
					next nil
				end
			end

		elsif event.has_type?(:KeyPressed) then
			if event.key_pressed?(:W) then
				@entities[0].accelerate(SDC.game.gravity * (-50.0))
			end

			@last_key_code = event.key_code.to_s

		end
	end

	def update
		if SDC::key_pressed?(:F10) then
			SDC.window.set_imgui_scale(2.0)

		elsif SDC::key_pressed?(:R) then
			@entities[0].sprites[0].position = SDC.xy(0, 0)
			@entities[0].sprites[0].origin = SDC.xy(25, 25)
			@entities[0].sprites[0].rotation += 30.0
			@entities[0].sprites[0].scale *= 1.01
		
		elsif SDC::key_pressed?(:F1, override_text_input: true) then
			# Should trigger an error with backtrace
			do_stuff_which_does_not_exist
		end

		@test_map.update

		@music.pitch *= (1.0 + (rand - 0.5)*0.1) if SDC.get_switch("chaos")

		if @decrease > 0 then
			@example_sound_1.pitch *= 0.99
			@example_sound_2.pitch *= 1.01
			@example_sound_3.pitch *= 0.97
			@decrease -= 1
		end

		v = 20.0 * (SDC.game.meter / SDC.game.second**2)
		dx = (SDC.key_pressed?(:A) ? -v : 0.0) + (SDC.key_pressed?(:D) ? v : 0.0)
		dy = (SDC.key_pressed?(:S) ? v : 0.0)

		@entities[0].accelerate(SDC.xy(dx, dy))

		@entities.each do |entity|
			@entities.each do |other_entity|
				next if !entity.test_box_collision_with(other_entity)
				entity.each_colliding_action_shape(other_entity) do |hurtshape, hitshape|
					entity.collision_with_entity(other_entity, hurtshape, hitshape)
				end
			end
		end

		@entities.each {|entity| entity.update}
		
		@counter += 1
	end

	def at_init
		@last_key_code = nil

		@counter = 0

		SDC::Data.load_sound_buffer(:Yeow, filename: "assets/sounds/Yeow.ogg")

		@example_sound = SDC::Sound.new
		@example_sound_1 = SDC::Sound.new
		@example_sound_2 = SDC::Sound.new
		@example_sound_3 = SDC::Sound.new
		@decrease = 0

		@example_sound.link_sound_buffer(SDC::Data.sound_buffers[:Yeow])
		@example_sound_1.link_sound_buffer(SDC::Data.sound_buffers[:Yeow])
		@example_sound_2.link_sound_buffer(SDC::Data.sound_buffers[:Yeow])
		@example_sound_3.link_sound_buffer(SDC::Data.sound_buffers[:Yeow])

		# Object loading is also possible with only the filename
		@music = SDC::Data.load_music_track(filename: "assets/music/Example.wav")
		@music.looping = true

		@text_buffer = ""

		@test_font = SDC::Data.load_font(filename: "assets/fonts/arial.ttf")
		SDC::Data.add_text("Hello,\nWorld", index: :helloworld_text)
		@test_text = SDC::Text.new(SDC::Data.texts[:helloworld_text], @test_font, 100)

		load_map

		@entities = []

		# You can create entities using their entity index or their class
		# The first option is useful if you want to iterate over all available classes
		@entities.push(create(SDC::Data.entities[:TestEntity]))
		@entities.push(create(TestEntity))
		@entities.push(create(TestEntity))

		@entities[0].position = SDC.xy(400, 400)

		@entities[1].position.x = 200
		@entities[1].position.y = 300

		@entities[0].set_child(@entities[2])
		@entities[2].position = SDC.xy(0.0, -50.0)
		@entities[2].boxes[0].scale = SDC.xy(0.5, 0.5)
		@entities[2].sprites[0].scale = SDC.xy(0.5, 0.5)
		@entities[2].shapes[0].scale = 0.5

		@test_toggle = false
		@test_value = 4
		@test_array = [1, 2, 3]
		@test_string = "Hello"
		@test_string2 = "Derp"
	end

	def at_exit
		SDC.text_input = nil
	end

	def load_map
		@test_map = SDC::Map.new(view_width: 30, view_height: 20)
		@test_map.load_from_file("dummy")
		@test_map.set_config(:TestMap)
	end

	def draw
		#SDC::Debug.log_time("Time = ") do
		view_player = SDC::View.new(SDC::FloatRect.new(@entities[0].position.x - 1280 * 0.5, @entities[0].position.y - 720 * 0.5, 1280, 720))
		SDC.window.set_view(view_player)
		@test_map.reload(@entities[0].position)
		@test_map.draw(SDC.window, SDC.xy(0, 0))
		@entities.each {|entity| entity.draw(SDC.window)}

		box_shape = SDC::DrawShapeRectangle.new
		box_shape.get_from(@entities[0].boxes[0])
		box_shape.fill_color = SDC::Color.new(255, 0, 0, 128)
		box_shape.outline_color = SDC::Color.new(0, 0, 255, 128)
		box_shape.outline_thickness = 2.0
		SDC.window.draw_translated(box_shape, 1, @entities[0].position)

		line_shape = SDC::DrawShapeLine.new
		line_shape.line = SDC.xy(200.0, 100.0)
		SDC.window.draw(line_shape, 0)
		
		view_minimap = SDC::View.new(SDC::FloatRect.new(@entities[0].position.x - 1280 * 0.5, @entities[0].position.y - 720 * 0.5, 1280, 720))
		view_minimap.set_viewport(SDC::FloatRect.new(0.8, 0.0, 0.2, 0.2))
		SDC.window.use_view(view_minimap) do
			@test_map.draw(SDC.window, SDC.xy(0, 0))
		end

		view_ui = SDC::View.new(SDC::FloatRect.new(0, 0, 1280, 720))
		SDC.window.use_view(view_ui) do
			SDC.window.draw(@test_text, 0)
		end
		#end
	end

	def draw_imgui
		SDC::ImGui.begin "Glorious Test Dialog Number 1" do

			shape_collision_no = 0
			box_collision_no = 0

			@entities.each do |entity|
				@entities.each do |other_entity|

					shape_collision_no += 1 if entity.test_shape_collision_with(other_entity)
					box_collision_no += 1 if entity.test_box_collision_with(other_entity)

				end
			end

			SDC::ImGui.text "Map was loaded #{SDC.get_variable("map_loaded")} times."
			SDC::ImGui.button "Reload map" {load_map}

			SDC::ImGui.button "Play music" {@music.play}
			SDC::ImGui.button "Pause music" {@music.pause}
			SDC::ImGui.button "Pitch up" {@music.pitch *= 1.1}
			SDC::ImGui.button "Pitch down" {@music.pitch /= 1.1}
			SDC::ImGui.button "Pitch ??? #{!SDC.get_switch("chaos") ? "on" : "off"}" {SDC.toggle_switch("chaos")}

			SDC::ImGui.button "Play sound" do
				@example_sound.play
			end

			SDC::ImGui.button "Play demonic sound" do
				@example_sound_1.pitch = 0.5
				@example_sound_2.pitch = 0.4
				@example_sound_3.pitch = 0.3

				@example_sound_1.play
				@example_sound_2.play
				@example_sound_3.play

				@decrease = 100
			end

			SDC::ImGui.text "Shape Collision: #{shape_collision_no.div(2)}"	# Filter double collisions
			SDC::ImGui.text "Box Collision:   #{box_collision_no.div(2)}"
			SDC::ImGui.text "Entity Collision: #{SDC.get_switch("coll")}"
			SDC.reset_switch("coll")
			SDC::ImGui.text "HP of entity 0: #{@entities[0].hp}"

			SDC::ImGui.text "Last key code: #{@last_key_code}"

			SDC::ImGui.text "On solid tile: #{@test_map.test_collision_with_entity(@entities[0])}"
			SDC::ImGui.button "Set dirt passable" {SDC::Data.tilesets[:Default].tiles[3].solid = false}

			SDC::ImGui.text "Counter = #{@counter}"

			SDC::ImGui.button "Reset mouse" {SDC::EventMouse.set_position([300, 200], SDC.window)}
			SDC::ImGui.text "Mouse pos = #{SDC.get_mouse_coords}"

			SDC::ImGui.button "Set text input to #{!SDC.text_input}" {SDC.text_input = !SDC.text_input}
			SDC::ImGui.text "Text = #{@text_buffer}"

			SDC::ImGui.button "Rescale entity" do
				@entities[0].shapes[0].scale *= 1.1
				@entities[0].boxes[0].scale *= 1.1
				@entities[0].sprites[0].scale *= 1.1
			end
			SDC::ImGui.button "Reset entity" do
				@entities[0].shapes[0].scale = 1.0
				@entities[0].boxes[0].scale = SDC.xy(1.0, 1.0)
				@entities[0].sprites[0].scale = SDC.xy(1.0, 1.0)
			end

			SDC::ImGui.button (SDC.get_switch("test") ? "Stop jumping with Q" : "Start jumping with Q") do
				SDC.toggle_switch("test")
			end
			SDC::ImGui.button "Amplify jumping" do
				SDC.multiply_variable("test", 1.05, default: 1000.0 * (SDC.game.meter / SDC.game.second**2))
			end

			if SDC::ImGui.button "Glorious Test Button Number 1" then
				@test_toggle = !@test_toggle
			end

			if @test_toggle then
				SDC::ImGui.begin_child "Some child" do
					SDC::ImGui.text "Oh yes, that button was pushed!"
				end
				SDC::ImGui.text "This text signifies that."
			end

			SDC::ImGui.input_int("Array", @test_array)

			SDC::ImGui.button "Test socket" do
				puts "Socket"
				@socket = SDC::Socket.new
				puts @socket.connect("127.0.0.1", 293)
				puts @socket.remote_address
				puts @socket.remote_port
				puts @socket.local_port
				puts @socket.send_message("TestBla")
			end

			SDC::ImGui.button "Test listener" do
				puts "Listener"
				@listener = SDC::Listener.new
				@socket = SDC::Socket.new
				puts @listener.listen(293)
				puts @listener.accept(@socket)
				puts @socket.remote_address
				puts @socket.remote_port
				puts @socket.local_port
				puts @socket.receive(100)
				puts @socket.last_message
			end

			SDC::ImGui.button "Toggle show sprite 0" do
				@entities[0].active_sprites[0] = !@entities[0].active_sprites[0]
			end

		end
	end
end