@[Anyolite::DefaultOptionalArgsToKeywordArgs]
@[Anyolite::ExcludeInstanceMethod("transform")]
@[Anyolite::ExcludeInstanceMethod("to_euler")]
@[Anyolite::SpecializeInstanceMethod("initialize", [x : Number = 0.0, y : Number = 0.0, z : Number = 0.0])]
@[Anyolite::WrapWithoutKeywordsInstanceMethod("initialize")]
@[Anyolite::SpecializeInstanceMethod("x=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("y=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("z=", [value], [value : Number])]
@[Anyolite::SpecializeInstanceMethod("+", [other : self])]
@[Anyolite::SpecializeInstanceMethod("-", [other : self])]
@[Anyolite::SpecializeInstanceMethod("*", [other : Number])]
@[Anyolite::SpecializeInstanceMethod("/", [other : Number])]
struct Rl::Vector3
  def initialize(x : Number = 0.0, y : Number = 0.0, z : Number = 0.0)
    self.x = x
    self.y = y
    self.z = z
  end
end