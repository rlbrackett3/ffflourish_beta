# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{slowhandcuke}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pete Hodgson"]
  s.date = %q{2010-11-07}
  s.description = %q{Cucumber formatter which gives feedback on the currently running step}
  s.email = ["public@thepete.net"]
  s.files = [".gitignore", "Gemfile", "README.md", "Rakefile", "example/cucumber.yml", "example/features/example.feature", "example/features/step_definitions/example_steps.rb", "lib/slowhandcuke.rb", "lib/slowhandcuke/formatter.rb", "lib/slowhandcuke/version.rb", "slowhandcuke.gemspec"]
  s.homepage = %q{http://github.com/moredip/slowhandcuke}
  s.post_install_message = %q{
*****************************************************************
* To use the slowhandcuke formatter, simple add                 *
*   --format 'Slowhandcuke::Formatter'                          * 
* to your cucumber.yml, Rakefile, or command line call          *
*****************************************************************

}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Cucumber formatter which gives feedback on the currently running step}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end
