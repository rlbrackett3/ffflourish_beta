# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{heroku-rails}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Elijah Miller", "Glenn Roberts", "Jacques Crocker"]
  s.date = %q{2010-11-24}
  s.description = %q{Manage multiple Heroku instances/apps for a single Rails app using Rake. It's the Capistrano for Heroku, without the suck.}
  s.email = %q{railsjedi@gmail.com}
  s.extra_rdoc_files = ["LICENSE", "README.md", "TODO", "CHANGELOG"]
  s.files = ["lib/generators/heroku/config_generator.rb", "lib/generators/templates/heroku.rake", "lib/generators/templates/heroku.yml", "lib/heroku/rails/heroku_config.rb", "lib/heroku/rails/heroku_runner.rb", "lib/heroku/rails/railtie.rb", "lib/heroku/rails/tasks.rb", "lib/heroku-rails.rb", "spec/fixtures/heroku-config.yml", "spec/heroku/rails/heroku_config_spec.rb", "spec/heroku/rails/heroku_runner_spec.rb", "spec/spec_helper.rb", "heroku-rails.gemspec", "Gemfile", "Gemfile.lock", "CHANGELOG", "LICENSE", "Rakefile", "README.md", "TODO"]
  s.homepage = %q{http://github.com/railsjedi/heroku-rails}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{none}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Deployment and configuration tools for Heroku/Rails}
  s.test_files = ["spec/fixtures/heroku-config.yml", "spec/heroku/rails/heroku_config_spec.rb", "spec/heroku/rails/heroku_runner_spec.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<heroku>, [">= 1.11.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
    else
      s.add_dependency(%q<heroku>, [">= 1.11.0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<heroku>, [">= 1.11.0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
  end
end
