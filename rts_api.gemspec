Gem::Specification.new do |s|
  s.name          = 'rts_api'
  s.version       = '0.1.0'
  s.date          = '2017-11-26'
  s.summary       = "RTS API"
  s.description   = "Ready Theatre Systems API library"
  s.authors       = ["Michael Sullivan"]
  s.email         = 'regularmike@gmail.com'
  s.files         = Dir["lib/**/*.rb"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_path  = "lib"
  s.homepage      = 'http://rubygems.org/gems/rts_api'
  s.license       = 'MIT'

  s.add_development_dependency "rspec", "~> 3.7"
end 
