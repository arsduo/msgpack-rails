# Once we get this library firm,
# we can submit pull requests to various third parties
# to integrate support for msgpack

if defined?(BSON)
  BSON::ObjectId.send(:include, MessagePack::SimpleSerialization)
end

if defined?(CarrierWave)
  module CarrierWave
    module Uploader
      module Url
        def to_msgpack(options = nil)
          as_json(options).to_msgpack(options)
        end
      end
    end
  end
end
