$:.push File.expand_path("../lib", __FILE__)

require 'asterisk_manager/version'

Gem::Specification.new do |s|
  s.name                      = 'asterisk_manager'
  s.version                   = AsteriskManager::VERSION
  s.authors                   = ["Kieran Johnson"]
  s.email                     = ['hello@invisiblelines.com']
  s.homepage                  = 'http://github.com/kieranj/asterisk_manager'
  s.files                     = Dir['Gemfile', 'README.md', 'Rakefile', 'lib/**/*']
  s.test_files                = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables               = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths             = ['lib']
  s.summary                   = s.summary

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'rb-inotify'
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'codeclimate-test-reporter'
end
