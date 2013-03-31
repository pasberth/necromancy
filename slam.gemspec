Gem::Specification.new do |s|
  s.name = "slam"
  s.version = File.read("VERSION")
  s.authors = ["pasberth"]
  s.description = %{Symbol-LAMbda hacks}
  s.summary = %q{experimental release. bug fix}
  s.email = "pasberth@gmail.com"
  s.homepage = "http://github.com/pasberth/slam"
  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.add_development_dependency "rspec"
end
