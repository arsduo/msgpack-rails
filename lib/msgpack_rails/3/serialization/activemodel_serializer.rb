module ActiveModel
  module Serializers
    module Msgpack
      def to_msgpack(options = {})
        options = {:out => options} if options.is_a?(String)
        options[:out] ||= ''

        # to_msgpack generates ASCII-8BIT strings
        # ensure that all encodings are compatible
        options[:out].force_encoding("ASCII-8BIT")

        options[:out] << as_json(options).to_msgpack
      end
      alias_method :to_mpac, :to_msgpack

      # TODO:  Test and uncomment this method
      #def from_msgpack(msg)
      # MessagePack.unpack(msg)
      #end
    end
  end
end

# don't create ActiveRecord if using an alternative ORM
if Object.const_defined?("ActiveRecord")
  module ActiveRecord
    module Serialization
      include ActiveModel::Serializers::Msgpack
    end
  end
end

module ActiveResource
  class Base
    include ActiveModel::Serializers::Msgpack
  end
end

# make this available to any ActiveModel object
module ActiveModel
  module Serialization
    include ActiveModel::Serializers::Msgpack
  end
end

if defined?(Mongoid)
  module Mongoid
    module Serialization
      include ActiveModel::Serializers::Msgpack
    end
  end
end