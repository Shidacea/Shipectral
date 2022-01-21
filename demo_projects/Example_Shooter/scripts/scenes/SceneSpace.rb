module ShooterTest
	class SceneSpace < SDC::Scene

		def handle_event(event)
			if event.has_type?(:Closed) then
				SDC.next_scene = nil
			elsif event.has_type?(:KeyReleased) then
				if event.key_pressed?(:Q) then
					@player_ship.rotate_drive(-1)
				end

				if event.key_pressed?(:E) then
					@player_ship.rotate_drive(1)
				end
			end
		end

		def at_init
			load_assets

			@player_ship = PlayerShip.new
			@player_ship.position = SDC.xy(300, 200)
			@particles = []
			@asteroids = []

			@space = Space.new(width: 100000, height: 100000, star_count: 1000)

			@player_ship.add_drive(:IonDrive)
			@player_ship.add_drive(:ImpulseDrive)
			@player_ship.add_drive(:DarkMatterDrive)
			@player_ship.add_drive(:DisplacementDrive)
			@player_ship.add_drive(:WarpDrive)
			@player_ship.add_drive(:HyperDrive)
			@player_ship.add_drive(:SubspaceDrive)
			@player_ship.add_drive(:QuantumDrive)
		
			@asteroids.push(Asteroid.new)
			@asteroids[0].position = SDC.xy(0, 0)
			@asteroids[0].velocity = SDC.xy(2 * SDC.game.dt, 2 * SDC.game.dt)
			@asteroids.push(Asteroid.new)
			@asteroids[1].position = SDC.xy(500, 500)
			@asteroids[1].velocity = SDC.xy(-1 * SDC.game.dt, -1 * SDC.game.dt)

			@bar_heat = SDC::Graphics::Shapes::Rectangle.new
			@bar_heat.origin = SDC.xy(0, 200)
			@bar_heat.size = SDC.xy(25, 200)

			@bar_health = SDC::Graphics::Shapes::Rectangle.new
			@bar_health.size = SDC.xy(310, 25)
		end

		def load_assets
			0.upto(8) do |i|
				texture = SDC::Graphics::Texture.new
				texture.load_from_file("assets/graphics/DriveIcons.png", texture_rect: SDC::IntRect.new(i * 20, 0, 20, 20))
				SDC::Data.add_texture(texture, index: "driveicon#{i}".to_sym)
			end
		end

		def draw
			view_player = SDC::Graphics::View.new(SDC::FloatRect.new(@player_ship.position.x - SDC.draw_width * 0.5, @player_ship.position.y - SDC.draw_height * 0.5, SDC.draw_width, SDC.draw_height))

			SDC.window.use_view(view_player) do
				@space.draw SDC.window
				@player_ship.draw SDC.window
				@asteroids.each {|asteroid| asteroid.draw(SDC.window)}
				@particles.each {|particle| particle.draw(SDC.window)}
			end

			heat_percent = @player_ship.selected_drive.heat_percentage
			@bar_heat.scale = SDC.xy(1.0, heat_percent)
			if @player_ship.selected_drive.overheated then
				@bar_heat.fill_color = SDC.color(255 * heat_percent, 255 - 255 * heat_percent, 0)
			else
				@bar_heat.fill_color = SDC.color(255 * heat_percent, 0, 255 - 255 * heat_percent)
			end
			SDC.window.draw_translated(@bar_heat, z: Z_BAR, at: SDC.xy(25, 225))

			@player_ship.drives.each do |drive|
				if drive == @player_ship.selected_drive then
					SDC.draw_texture(index: "driveicon#{drive.identification}".to_sym, z: Z_DRIVE_ICON, scale: SDC.xy(1.5, 1.5), coordinates: SDC.xy(75 + drive.identification * 35, 5))
				else
					SDC.draw_texture(index: "driveicon#{drive.identification}".to_sym, z: Z_DRIVE_ICON, scale: SDC.xy(1.5, 1.5), coordinates: SDC.xy(75 + drive.identification * 35, 5), color: SDC.color(128, 128, 128, alpha: 128))
				end
			end

			health_percent = @player_ship.health_percentage
			@bar_health.scale = SDC.xy(health_percent, 1.0)
			@bar_health.fill_color = SDC.color(255 - 255 * health_percent, 255 * health_percent, 63 * health_percent)
			SDC.window.draw_translated(@bar_health, z: Z_BAR, at: SDC.xy(75, 60))

			minimap_shape = SDC::Graphics::Shapes::Rectangle.new
			minimap_shape.size = SDC.xy(SDC.draw_width * 0.2, SDC.draw_height * 0.2)
			minimap_shape.fill_color = SDC.color(128, 128, 128, alpha: 128)
			SDC.window.draw_translated(minimap_shape, z: Z_MINIMAP, at: SDC.xy(SDC.draw_width * 0.775, SDC.draw_height * 0.05))

			view_minimap = SDC::Graphics::View.new(SDC::FloatRect.new(0, 0, @space.width, @space.height))
			view_minimap.set_viewport(SDC::FloatRect.new(0.775, 0.05, 0.2, 0.2))

			SDC.window.use_view(view_minimap) do
				player_indicator = SDC::Graphics::Shapes::Rectangle.new
				player_indicator.size = SDC.xy(@space.width * 0.01, @space.height * 0.02)
				player_indicator.fill_color = SDC.color(255, 0, 0, alpha: 255)
				SDC.window.draw_translated(player_indicator, z: Z_MINIMAP, at: @player_ship.position)

				asteroid_indicator = SDC::Graphics::Shapes::Rectangle.new
				asteroid_indicator.size = SDC.xy(@space.width * 0.01, @space.height * 0.02)
				asteroid_indicator.fill_color = SDC.color(255, 0, 0, alpha: 255)
				@asteroids.each do |asteroid|
					SDC.window.draw_translated(asteroid_indicator, z: Z_MINIMAP, at: asteroid.position)
				end
			end
		end

		def in_cam(pos, tolerance: 0)
			return false if !pos.x.between?(@player_ship.position.x - SDC.draw_width * 0.5 - tolerance, @player_ship.position.x + SDC.draw_width * 0.5 + tolerance)
			return false if !pos.y.between?(@player_ship.position.y - SDC.draw_height * 0.5 - tolerance, @player_ship.position.y + SDC.draw_height * 0.5 + tolerance)
			return true
		end

		def add_particle(particle)
			@particles.push(particle)
		end

		def check_collisions
			0.upto(@asteroids.size - 1) do |i|
				(i + 1).upto(@asteroids.size - 1) do |j|
					next if !@asteroids[i].test_box_collision_with(@asteroids[j])
					if @asteroids[i].test_shape_collision_with(@asteroids[j]) then
						@asteroids[i].collision_with_entity(@asteroids[j], nil, nil)
						@asteroids[j].collision_with_entity(@asteroids[i], nil, nil)
					end
				end
				if @player_ship.test_box_collision_with(@asteroids[i]) then
					if @player_ship.test_shape_collision_with(@asteroids[i]) then
						@asteroids[i].collision_with_entity(@player_ship, nil, nil)
						@player_ship.collision_with_entity(@asteroids[i], nil, nil)
					end
				end
			end
		end

		def update
			if SDC.key_pressed?(:A) then
				@player_ship.rotate(-5.0)
			end

			if SDC.key_pressed?(:D) then
				@player_ship.rotate(5.0)
			end

			if SDC.key_pressed?(:W) then
				@player_ship.boost
			end

			if SDC.key_pressed?(:S) then
				@player_ship.brake
			end

			@player_ship.update
			@particles.reject! do |particle|
				particle.update
				particle.gone
			end

			@asteroids.each {|asteroid| asteroid.update}
			SDC.scene.check_collisions
		end

	end
end