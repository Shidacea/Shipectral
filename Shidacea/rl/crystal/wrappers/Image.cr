@[Anyolite::DefaultOptionalArgsToKeywordArgs]
struct Rl::Image
  def self.load_from_file(filename : String)
    Rl.load_image(filename)
  end
end