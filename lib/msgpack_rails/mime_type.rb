Mime::Type.register "application/x-mpac", :mpac, %w( application/x-msgpack )

# Let's action_dispatch parse the params into the params hash when it receives an mpac request.
# No idea how to get this in there without adding it to this DEFAULT_PARSERS hash.
ActionDispatch::ParamsParser::DEFAULT_PARSERS.merge!(Mime::MPAC =>
  lambda do |contents|
    data = MessagePack.unpack(contents)
    data.with_indifferent_access
  end
)