# add render option for msgpack
ActionController::Renderers.add :msgpack do |data, options|
  msg = data.to_msgpack(options)
  self.content_type ||= Mime::MPAC
  msg
end