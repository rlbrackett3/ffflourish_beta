# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongoid_slug}
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paper Cavalier"]
  s.date = %q{2011-01-16}
  s.description = %q{Mongoid Slug generates a URL slug or permalink based on one or more fields in a Mongoid model.}
  s.email = ["code@papercavalier.com"]
  s.files = ["lib/mongoid/slug/version.rb", "lib/mongoid/slug.rb", "LICENSE", "README.md", "spec/models/author.rb", "spec/models/book.rb", "spec/models/partner.rb", "spec/models/person.rb", "spec/models/relationship.rb", "spec/models/subject.rb", "spec/mongoid/slug_spec.rb", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/papercavalier/mongoid-slug}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{mongoid_slug}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Generates a URL slug}
  s.test_files = ["spec/models/author.rb", "spec/models/book.rb", "spec/models/partner.rb", "spec/models/person.rb", "spec/models/relationship.rb", "spec/models/subject.rb", "spec/mongoid/slug_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mongoid>, ["~> 2.0.0.rc.5"])
      s.add_runtime_dependency(%q<stringex>, ["~> 1.2.0"])
      s.add_development_dependency(%q<bson_ext>, ["~> 1.1.5"])
      s.add_development_dependency(%q<database_cleaner>, ["~> 0.6.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.4.0"])
      s.add_development_dependency(%q<ruby-debug19>, ["~> 0.11.0"])
    else
      s.add_dependency(%q<mongoid>, ["~> 2.0.0.rc.5"])
      s.add_dependency(%q<stringex>, ["~> 1.2.0"])
      s.add_dependency(%q<bson_ext>, ["~> 1.1.5"])
      s.add_dependency(%q<database_cleaner>, ["~> 0.6.0"])
      s.add_dependency(%q<rspec>, ["~> 2.4.0"])
      s.add_dependency(%q<ruby-debug19>, ["~> 0.11.0"])
    end
  else
    s.add_dependency(%q<mongoid>, ["~> 2.0.0.rc.5"])
    s.add_dependency(%q<stringex>, ["~> 1.2.0"])
    s.add_dependency(%q<bson_ext>, ["~> 1.1.5"])
    s.add_dependency(%q<database_cleaner>, ["~> 0.6.0"])
    s.add_dependency(%q<rspec>, ["~> 2.4.0"])
    s.add_dependency(%q<ruby-debug19>, ["~> 0.11.0"])
  end
end
