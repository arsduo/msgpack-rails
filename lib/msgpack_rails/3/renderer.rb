# add render option for msgpack
ActionController::Renderers.add :msgpack do |data, options|
  # if it's an ActiveModel resource, serialize with the options hash
  # otherwise, generate message pack with out: ""
  # not happy that to_msgpack has different signatures for different objects >:O
  opts = data.respond_to?(:serializable_hash) ? options : (options[:out] || "")
  self.content_type ||= Mime::MPAC
  response.headers['Content-type'] ||= "#{Mime::MPAC}; charset=x-user-defined"
  data.to_msgpack(opts)
end