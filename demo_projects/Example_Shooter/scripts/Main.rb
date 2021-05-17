# The absolute main file
# Everything starts here

limiter = SDC::Limiter.new(max: 720, renders_per_second: 60, ticks_per_second: 60, gc_per_second: 60)
SDC.main_routine(ShooterTest::SceneSpace, game_class: ShooterTest::Game, title: 'Shidacea Shooter', width: 1280, height: 720, limiter: limiter)
