# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: kismet-gpsxml 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "kismet-gpsxml"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Colin Dean"]
  s.date = "2014-09-14"
  s.description = "A quick solution to model Kismet-generated gpsxml log files and output to CSV"
  s.email = "colin.dean@metamesh.org"
  s.executables = ["gpsxml-filter-bad-bssid", "gpsxml2csv"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".travis.yml",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/gpsxml-filter-bad-bssid",
    "bin/gpsxml2csv",
    "kismet-gpsxml.gemspec",
    "lib/kismet-gpsxml.rb",
    "test/helper.rb",
    "test/test.xml",
    "test/test_kismet-gpsxml.rb"
  ]
  s.homepage = "http://github.com/pittmesh/kismet-gpsxml"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "A quick solution to model Kismet-generated gpsxml log files and output to CSV"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.6.3.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<minitest-spec-expect>, ["~> 2.0.0"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.6.3.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<minitest-spec-expect>, ["~> 2.0.0"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.6.3.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<minitest-spec-expect>, ["~> 2.0.0"])
  end
end

