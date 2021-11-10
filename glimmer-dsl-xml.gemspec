# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glimmer-dsl-xml 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "glimmer-dsl-xml".freeze
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["AndyMaleh".freeze]
  s.date = "2021-11-10"
  s.description = "Glimmer DSL for XML (& HTML)".freeze
  s.email = "andy.am@gmail.com".freeze
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "README.md",
    "VERSION",
    "lib/glimmer-dsl-xml.rb",
    "lib/glimmer/dsl/xml/dsl.rb",
    "lib/glimmer/dsl/xml/html_expression.rb",
    "lib/glimmer/dsl/xml/meta_expression.rb",
    "lib/glimmer/dsl/xml/name_space_expression.rb",
    "lib/glimmer/dsl/xml/node_parent_expression.rb",
    "lib/glimmer/dsl/xml/tag_expression.rb",
    "lib/glimmer/dsl/xml/text_expression.rb",
    "lib/glimmer/dsl/xml/xml_expression.rb",
    "lib/glimmer/dsl/xml/xml_node_expression.rb",
    "lib/glimmer/xml/depth_first_search_iterator.rb",
    "lib/glimmer/xml/html_node.rb",
    "lib/glimmer/xml/html_visitor.rb",
    "lib/glimmer/xml/name_space_visitor.rb",
    "lib/glimmer/xml/node.rb",
    "lib/glimmer/xml/node_visitor.rb",
    "lib/glimmer/xml/xml_visitor.rb"
  ]
  s.homepage = "http://github.com/AndyObtiva/glimmer-dsl-xml".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.22".freeze
  s.summary = "Glimmer DSL for XML".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer>.freeze, ["~> 2.4.1"])
    s.add_development_dependency(%q<rspec-mocks>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<puts_debuggerer>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 10.1.0", "< 14.0.0"])
    s.add_development_dependency(%q<jeweler>.freeze, [">= 2.3.9", "< 3.0.0"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 6.2.1", "< 7.0.0"])
    s.add_development_dependency(%q<coveralls>.freeze, ["= 0.8.23"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, ["~> 0.7.0"])
    s.add_development_dependency(%q<rake-tui>.freeze, [">= 0"])
  else
    s.add_dependency(%q<glimmer>.freeze, ["~> 2.4.1"])
    s.add_dependency(%q<rspec-mocks>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<puts_debuggerer>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 10.1.0", "< 14.0.0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 2.3.9", "< 3.0.0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 6.2.1", "< 7.0.0"])
    s.add_dependency(%q<coveralls>.freeze, ["= 0.8.23"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_dependency(%q<simplecov-lcov>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<rake-tui>.freeze, [">= 0"])
  end
end

