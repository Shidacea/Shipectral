module SDCHelper
  macro wrap_type(x)
    @data : {{x}}?
    
    @[Anyolite::Exclude]
    def data
      @data.not_nil!
    end

    def data?
      !!@data
    end
  end
end
