require 'msgpack'
require 'mime/types'
require 'msgpack_rails/mime_type'

module MessagePack
  # add this to your config file so MessagePack requests get processed
  module Rails
    def self.register_parser(config)
      ActionDispatch::ParamsParser::DEFAULT_PARSERS.merge!({
        Mime::MPAC => Proc.new do |data|
          MessagePack.unpack(data).with_indifferent_access
        end
      })
    end
  end
end