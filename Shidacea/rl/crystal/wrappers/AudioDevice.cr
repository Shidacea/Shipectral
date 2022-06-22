module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class AudioDevice
    @master_volume : Float32 = 1.0

    def initialize
      Rl.init_audio_device
    end

    def close
      Rl.close_audio_device
    end

    def ready?
      Rl.audio_device_ready?
    end

    def master_volume
      @master_volume
    end

    def master_volume=(value : Float)
      @master_volume = value.to_f32
      Rl.set_master_volume(value)
    end

    def finalize
      close
    end
  end
end