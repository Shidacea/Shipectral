module SDCHelper
  macro wrap_type(x)
    @data : {{x}}?
    
    @[Anyolite::Exclude]
    def data
      if data = @data
        data.not_nil!
      else
        SDC.error "Internal data of type {{x}} was used after being reset"
      end
    end

    def data?
      !!@data
    end
  end
end
