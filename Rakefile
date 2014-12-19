# encoding: utf-8
$:.unshift File.dirname(__FILE__) + 'lib'
require "bundler/gem_tasks"
require "rdoc/task"
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default=> :spec

Rake::RDocTask.new(:rdoc_dev) do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
  rd.options << "--all"
end

desc "Generar documentación de las pruebas (HTML)"
task :doc_HTML do
     sh "rspec -I. -Ilib -Ilib/orange -Ispec spec/orange_spec.rb --format html > doc/pruebas/index.html"
end

desc "Generar documentación de las pruebas"
task :doc do
     sh "rspec -I. -Ilib -Ilib/orange -Ispec spec/orange_spec.rb --format documentation"
end
