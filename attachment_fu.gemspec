# require File.expand_path("../lib/technoweenie/attachment_fu/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "attachment_fu"
  # s.version     = Technoweenie::AttachmentFu::VERSION
  s.version = 1
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Technoweenie"]
  s.email       = [""]
  s.homepage    = "http://github.com/yyyc514/attachment_fu"
  s.summary     = "modified version of attachment_fu"
  s.description = "modified version of attachment_fu (that is not a plugin)"

  s.required_rubygems_version = ">= 1.3.6"

  # lol - required for validation
  s.rubyforge_project         = "attachment_fu"

  # If you have other dependencies, add them here
  s.add_dependency "rails", "~> 3.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  # If you need an executable, add it here
  # s.executables = ["newgem"]

  # If you have C extensions, uncomment this line
  # s.extensions = "ext/extconf.rb"
end