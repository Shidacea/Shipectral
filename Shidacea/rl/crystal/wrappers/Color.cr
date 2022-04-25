@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::SpecializeInstanceMethod("initialize", [r : UInt8 = 0, g : UInt8 = 0, b : UInt8 = 0, a : UInt8 = 255])]
@[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
@[Anyolite::SpecializeInstanceMethod("r=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("g=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("b=", [value], [value : UInt8])]
@[Anyolite::SpecializeInstanceMethod("a=", [value], [value : UInt8])]
struct Rl::Color
  def initialize(r : UInt8 = 0, g : UInt8 = 0, b : UInt8 = 0, a : UInt8 = 255)
    self.r = r
    self.g = g
    self.b = b
    self.a = a
  end
end