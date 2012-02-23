module ActiveModel
  module Serializers
    module Msgpack
      def to_msgpack(options = {})
        options = {:out => options} if options.is_a?(String)
        options[:out] ||= ''

        puts "Out: #{options[:out].inspect}"
        puts "Out: #{options[:out].encoding}"
        options[:out].force_encoding("ASCII-8BIT")
        puts "Out encoding: #{options[:out].encoding}"

        options[:out] << as_json(options).to_msgpack.tap{|d| puts "done with this: #{d.encoding}"}
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