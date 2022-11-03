module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Param
    @content : Nil | Bool | Float32 | Int32 | String | Array(SDC::Param) | Hash(SDC::Param, SDC::Param)
    
    def initialize(@content : Nil | Bool | Float32 | Int32 | String | Array(SDC::Param) | Hash(SDC::Param, SDC::Param))
    end

    def as_string
      @content.as(String)
    end

    def as_int
      @content.as(Int32)
    end

    def value
      @content
    end

    @[Anyolite::WrapWithoutKeywords]
    def [](index : Int32)
      @content.as(Array)[index]
    end
  end
end