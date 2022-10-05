module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Event
    @data : LibSDL::Event

    @[Anyolite::Exclude]
    def data
      @data
    end

    @[Anyolite::Specialize]
    def initialize(other_event : SDC::Event)
      @data = other_event.data
    end

    def initialize(raw_event : LibSDL::Event)
      @data = raw_event
    end

    # TODO: The following methods are just for testing and will be replaced eventually

    def window_event?
      @data.type == LibSDL::EventType::WINDOWEVENT.to_i
    end

    def window_close_event?
      @data.window.event == LibSDL::WindowEventID::WINDOWEVENT_CLOSE.to_i
    end

    def window_id
      @data.window.window_id
    end
  end
end