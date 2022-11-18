module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class EntityState
    @content : Hash(String, Anyolite::RbRef) = {} of String => Anyolite::RbRef

    def initialize
    end

    def [](name : String)
      if @content[name]?
        @content[name]
      else
        SDC.error "Entity state did not contain #{name}"
      end
    end

    def []=(name : String, value : Anyolite::RbRef)
      @content[name] = value
    end
  end
end