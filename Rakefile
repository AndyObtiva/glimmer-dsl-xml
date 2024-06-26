require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
begin
  jeweler_required = require 'jeweler'
rescue Exception
  jeweler_required = nil
end
unless jeweler_required.nil?
  Jeweler::Tasks.new do |gem|
    # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
    gem.name = "glimmer-dsl-xml"
    gem.homepage = "http://github.com/AndyObtiva/glimmer-dsl-xml"
    gem.license = "MIT"
    gem.summary = %Q{Glimmer DSL for XML}
    gem.description = %Q{Glimmer DSL for XML & HTML}
    gem.email = "andy.am@gmail.com"
    gem.authors = ["AndyMaleh"]
    gem.executables = ['html_to_glimmer']
    gem.files = Dir['README.md', 'LICENSE.txt', 'VERSION', 'CHANGELOG.md', 'CONTRIBUTING.md', 'lib/**/*']
    # dependencies defined in Gemfile
  end
  Jeweler::RubygemsDotOrgTasks.new
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  # spec.ruby_opts = ["-Xcli.debug=true --debug #{Glimmer::Launcher.jruby_swt_options}"]
  # NOTE: Disabled debug flags because they were giving noisy output on raise of an error

  # spec.ruby_opts = ["--profile.graph #{Glimmer::Launcher.jruby_swt_options}"]
  # require 'jruby/profiler'
  # profile_data = JRuby::Profiler.profile do
  # end

#   spec.ruby_opts = [Glimmer::Launcher.jruby_swt_options]
end

task :default => :spec

task :no_puts_debuggerer do
  ENV['puts_debuggerer'] = 'false'
end

namespace :build do
  desc 'Builds without running specs for quick testing, but not release'
  task :prototype => :no_puts_debuggerer do
    Rake::Task['build'].execute
  end
end

Rake::Task["build"].enhance [:no_puts_debuggerer, :spec]
