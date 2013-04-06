Gem::Specification.new do |s|
  s.name = "necromancy"
  s.version = File.read("VERSION")
  s.authors = ["pasberth"]
  s.description = %{Necromancy conjures up the functional code.}
  s.summary = %q{experimental release}
  s.email = "pasberth@gmail.com"
  s.homepage = "http://github.com/pasberth/necromancy"
  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.add_development_dependency "rspec"
end
