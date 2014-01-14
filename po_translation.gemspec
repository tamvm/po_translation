# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'po/version'

Gem::Specification.new do |gem|
  gem.name          = "po_translation"
  gem.license       = "MIT"
  gem.version       = Po::VERSION
  gem.authors       = ["Tam Vo"]
  gem.email         = ["vo.mita.ov@gmail.com"]
  gem.description   = %q{Using google translate to translate your po file}
  gem.summary       = %q{Using google translate to translate your po file}
  gem.homepage      = "http://github.com/tamvo/po_translation"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency("mechanize")
  gem.add_dependency("active_support")
  gem.add_dependency("get_pomo")
  gem.add_dependency("htmlentities")
end

