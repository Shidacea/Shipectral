module SDC
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  class Param
    @content : Nil | Bool | Int32 | Float32 | String | Array(SDC::Param) | Hash(SDC::Param, SDC::Param)
    
    def initialize(@content : Nil | Bool | Int32 | Float32 | String | Array(SDC::Param) | Hash(SDC::Param, SDC::Param))
    end

    def as_string
      @content.as(String)
    end
  end
end