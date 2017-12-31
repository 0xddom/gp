# encoding: utf-8
require File.expand_path("../lib/gp/version", __FILE__)

Gem::Specification.new do |s|
    #Metadata
    s.name = "gp"
    s.version = Gp::VERSION
    s.authors = ["foldr"]
    s.email = ["danieldominguez05@gmail.com"]
    s.homepage = ""
    s.summary = %q{GP experiments}
    s.description = %q{GP experiments in clasic Koza and OOGP}
    s.licenses = ['']
# If you want to show a post-install message, uncomment the following lines
#    s.post_install_message = <<-MSG
#
#MSG

    #Manifest
    s.files = `git ls-files`.split("\n")
    s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
    s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    s.require_paths = ['lib']

    
    s.add_runtime_dependency 'thor', '~> 0.19'
    s.add_runtime_dependency 'gtk3', '~> 3.0', '>= 3.0.7'
    
    s.add_development_dependency 'rake'
end
