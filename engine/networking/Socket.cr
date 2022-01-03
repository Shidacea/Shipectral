module SF
  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::SpecializeInstanceMethod("connect", [remote_address : IpAddress, remote_port : Int, timeout : Time = Time::Zero], [remote_address : IpAddress, remote_port : Int, timeout : Time = SF::Time::Zero])]
  @[Anyolite::SpecializeInstanceMethod("send", [packet : Packet])]
  @[Anyolite::SpecializeInstanceMethod("receive", [packet : Packet])]
  class TcpSocket
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::SpecializeInstanceMethod("listen", [port : Int, address : IpAddress = IpAddress::Any], [port : Int, address : IpAddress = SF::IpAddress::Any])]
  class TcpListener
  end

  @[Anyolite::DefaultOptionalArgsToKeywordArgs]
  @[Anyolite::SpecializeInstanceMethod("initialize", [address : String])]
  @[Anyolite::SpecializeClassMethod("get_public_address", [timeout : Time = Time::Zero], [timeout : Time = SF::Time::Zero])]
  struct IpAddress
  end
end

def setup_ruby_socket_class(rb)
  Anyolite.wrap(rb, SF::TcpSocket, under: SF, verbose: true)
  Anyolite.wrap(rb, SF::TcpListener, under: SF, verbose: true)
  Anyolite.wrap(rb, SF::IpAddress, under: SF, verbose: true)
end