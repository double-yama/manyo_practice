# -*- encoding: utf-8 -*-
# stub: heroku-forward 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "heroku-forward".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel Doubrovkine".freeze]
  s.date = "2013-08-01"
  s.email = "dblock@dblock.org".freeze
  s.extra_rdoc_files = ["LICENSE.md".freeze, "README.md".freeze]
  s.files = ["LICENSE.md".freeze, "README.md".freeze]
  s.homepage = "http://github.com/dblock/heroku-forward".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2".freeze
  s.summary = "Beat Heroku's 60s boot timeout with a forward proxy.".freeze

  s.installed_by_version = "2.5.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<em-proxy>.freeze, [">= 0.1.8"])
      s.add_runtime_dependency(%q<i18n>.freeze, ["~> 0.6"])
      s.add_runtime_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<spoon>.freeze, ["~> 0.0.1"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.6"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<thin>.freeze, ["~> 1.5"])
      s.add_development_dependency(%q<unicorn>.freeze, ["~> 4.5"])
      s.add_development_dependency(%q<puma>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<em-http-request>.freeze, ["~> 1.0"])
    else
      s.add_dependency(%q<em-proxy>.freeze, [">= 0.1.8"])
      s.add_dependency(%q<i18n>.freeze, ["~> 0.6"])
      s.add_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_dependency(%q<spoon>.freeze, ["~> 0.0.1"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.6"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 1.6"])
      s.add_dependency(%q<thin>.freeze, ["~> 1.5"])
      s.add_dependency(%q<unicorn>.freeze, ["~> 4.5"])
      s.add_dependency(%q<puma>.freeze, ["~> 1.6"])
      s.add_dependency(%q<em-http-request>.freeze, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<em-proxy>.freeze, [">= 0.1.8"])
    s.add_dependency(%q<i18n>.freeze, ["~> 0.6"])
    s.add_dependency(%q<ffi>.freeze, [">= 0"])
    s.add_dependency(%q<spoon>.freeze, ["~> 0.0.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.6"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 1.6"])
    s.add_dependency(%q<thin>.freeze, ["~> 1.5"])
    s.add_dependency(%q<unicorn>.freeze, ["~> 4.5"])
    s.add_dependency(%q<puma>.freeze, ["~> 1.6"])
    s.add_dependency(%q<em-http-request>.freeze, ["~> 1.0"])
  end
end
