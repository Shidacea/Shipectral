# The absolute main file
# Everything starts here

limiter = SDC::Limiter.new(max: 720, renders_per_second: 60, ticks_per_second: 60, gc_per_second: 60)
SDC.main_routine(SceneTest, game_class: SDC::Game, title: 'Shidacea Test Application', width: 1280, height: 720, limiter: limiter)
