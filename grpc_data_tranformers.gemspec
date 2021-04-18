Gem::Specification.new do |s|
  s.name        = 'grpc_data_tranformers'
  s.version     = '0.0.0'
  s.date        = '2020-08-22'
  s.summary     = "Ruby Grpc data tranformers"
  s.description = "A simple gem to convert from Grpc object to Hash and vice versa"
  s.authors     = ["kathir"]
  s.email       = 'kathirvalavan.ict@gmail.com'
  s.files       = ["lib/grpc_data_transformers.rb"]
  s.homepage    =
      'https://rubygems.org/gems/grpc_data_transformers'
  s.license       = 'MIT'
  s.metadata    = { "source_code_uri" => "https://github.com/kathirvalavan/grpc_data_transformers" }
  s.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'grpc-tools', '~> 1.17.1'
  spec.add_dependency 'grpc', '~> 1.17.1'
  spec.add_dependency 'google-protobuf', '~> 3.6.1'

end