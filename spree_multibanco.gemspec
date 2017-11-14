# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_multibanco'
  s.version     = '3.0.0'
  s.summary     = 'Spree extension for handling payments via Multibanco'
  s.description = 'Currently supports Ifthenpay (ifthenpay.com)'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Vasco Santos'
  s.email     = 'vasco.f.santos@gmail.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.0.0'
end
