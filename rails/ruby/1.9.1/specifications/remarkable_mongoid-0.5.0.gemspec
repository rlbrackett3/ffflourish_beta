# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{remarkable_mongoid}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Cardarella"]
  s.date = %q{2010-10-15}
  s.description = %q{RSpec Matchers for Mongoid}
  s.email = %q{bcardarella@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.markdown"]
  s.files = ["LICENSE", "README.markdown", "lib/remarkable/mongoid.rb", "lib/remarkable/mongoid/associations.rb", "lib/remarkable/mongoid/fields.rb", "lib/remarkable/mongoid/validate_association.rb", "lib/remarkable/mongoid/validate_uniqueness_of.rb"]
  s.homepage = %q{http://github.com/bcardarella/remarkable_mongoid}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{RSpec Matchers for Mongoid}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<remarkable_activemodel>, [">= 4.0.0.alpha2"])
      s.add_development_dependency(%q<ruby-debug>, [">= 0"])
      s.add_development_dependency(%q<bson_ext>, [">= 0"])
      s.add_development_dependency(%q<activesupport>, ["= 3.0.0.rc"])
      s.add_development_dependency(%q<mongoid>, ["= 2.0.0.beta.15"])
      s.add_development_dependency(%q<rspec>, ["= 2.0.0.beta.19"])
      s.add_development_dependency(%q<bourne>, ["= 1.0"])
    else
      s.add_dependency(%q<remarkable_activemodel>, [">= 4.0.0.alpha2"])
      s.add_dependency(%q<ruby-debug>, [">= 0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<activesupport>, ["= 3.0.0.rc"])
      s.add_dependency(%q<mongoid>, ["= 2.0.0.beta.15"])
      s.add_dependency(%q<rspec>, ["= 2.0.0.beta.19"])
      s.add_dependency(%q<bourne>, ["= 1.0"])
    end
  else
    s.add_dependency(%q<remarkable_activemodel>, [">= 4.0.0.alpha2"])
    s.add_dependency(%q<ruby-debug>, [">= 0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<activesupport>, ["= 3.0.0.rc"])
    s.add_dependency(%q<mongoid>, ["= 2.0.0.beta.15"])
    s.add_dependency(%q<rspec>, ["= 2.0.0.beta.19"])
    s.add_dependency(%q<bourne>, ["= 1.0"])
  end
end
