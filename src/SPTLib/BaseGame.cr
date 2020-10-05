module SPT
  class BaseGame
    getter dt : Float32
    getter meter : Float32
    getter second : Float32

    property gravity : SPT::Coordinates

    def initialize
      # Distance unit in pixels
      @meter = 50.0

      # Time unit in frames
      @second = 60.0

      # Physics time step
      @dt = 1.0

      # Gravity
      @gravity = SPT::Coordinates.new(0, 30.0) * (@meter / @second**2)

      # Basic hash for global and local switches
      @switches = {} of SPT::IndexType => Bool

      # Basic hash for global and local variables
      @variables = {} of SPT::IndexType => Int32 | Float32
    end

    # Methods for manipulating switches

    def get_switch(index)
      return @switches[index]?
    end

    def set_switch(index, value = true)
      @switches[index] = value
    end

    def toggle_switch(index)
      @switches[index] = !@switches[index]?
    end

    # Methods for manipulating variables

    def get_variable(index, default = nil)
      return @variables[index]? ? @variables[index] : default
    end

    def set_variable(index, value)
      @variables[index] = value
    end

    # Special numerical options for variables

    def increase_variable(index, value = 1, default = 0)
      @variables[index] = @variables[index]? ? @variables[index] + value : default + value
    end

    def decrease_variable(index, value = 1, default = 0)
      @variables[index] = @variables[index]? ? @variables[index] - value : default - value
    end

    def multiply_variable(index, value, default = 0)
      @variables[index] = @variables[index]? ? @variables[index] * value : default * value
    end
  end
end
