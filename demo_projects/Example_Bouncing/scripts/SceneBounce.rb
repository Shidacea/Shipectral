class SceneBounce < SDC::Scene
  def handle_event(event)
    if event.has_type?(:Closed) then
      SDC.next_scene = nil
    end
  end

  def at_init
    @balls = []

    50.times {@balls.push(BouncingBall.new)}
  end

  def update
    @balls.each {|ball| ball.update}
  end

  def draw
    @balls.each {|ball| ball.draw(SDC.window)}
  end
end