# encoding: UTF-8
module MessagePack
  module DateTimeSerialization
    def to_msgpack(out = "")
      # strip out the leading and ending quotes
      self.to_json[1...-1].to_msgpack(out)
    end
  end

  module SimpleSerialization
    def to_msgpack(out = "")
      (self.respond_to?(:as_json) ? as_json : (self.respond_to?(:to_json) ? to_json : to_s)).to_msgpack(out)
    end
  end
end

[Time, DateTime, Date].each do |klass|
  klass.send(:include, MessagePack::DateTimeSerialization)
end

