$:.push File.expand_path("../lib", __FILE__)

require 'asterisk-manager/version'

Gem::Specification.new do |s|
  s.name                      = 'asterisk-manager'
  s.version                   = AsteriskManager::VERSION
  s.authors                   = ["Kieran Johnson"]
  s.email                     = ['hello@invisiblelines.com']
  s.homepage                  = 'http://github.com/kieranj/asterisk-manager'
  s.files                     = Dir['Gemfile', 'README.rdoc', 'Rakefile', 'lib/**/*']
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables               = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths             = ['lib']
  s.summary                   = s.summary
end
