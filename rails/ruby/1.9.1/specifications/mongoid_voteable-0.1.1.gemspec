# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongoid_voteable}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Coene"]
  s.date = %q{2010-08-08}
  s.description = %q{Provides fields and methods for the manipulation of votes on a Mongoid model.}
  s.email = %q{jcoene@gmail.com}
  s.files = ["lib/mongoid_voteable.rb", "README.rdoc"]
  s.homepage = %q{http://github.com/jcoene/mongoid_voteable}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Voting functionality for Mongoid models}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, [">= 2.0.0.beta.16"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0.rc"])
      s.add_development_dependency(%q<bson_ext>, [">= 1.0.4"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.5.2"])
    else
      s.add_dependency(%q<mongoid>, [">= 2.0.0.beta.16"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0.rc"])
      s.add_dependency(%q<bson_ext>, [">= 1.0.4"])
      s.add_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
      s.add_dependency(%q<database_cleaner>, [">= 0.5.2"])
    end
  else
    s.add_dependency(%q<mongoid>, [">= 2.0.0.beta.16"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0.rc"])
    s.add_dependency(%q<bson_ext>, [">= 1.0.4"])
    s.add_dependency(%q<rspec>, [">= 2.0.0.beta.19"])
    s.add_dependency(%q<database_cleaner>, [">= 0.5.2"])
  end
end
