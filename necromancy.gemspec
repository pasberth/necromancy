version = File.read("VERSION").chomp
`perl -i -pe 's/VERSION = "[\\d\\.]+"/VERSION = "#{version}"/' lib/necromancy/version.rb`
Gem::Specification.new do |s|
  s.name = "necromancy"
  s.version = version
  s.authors = ["pasberth"]
  s.description = %{Necromancy conjures up the functional code.}
  s.summary = %q{experimental release}
  s.email = "pasberth@gmail.com"
  s.homepage = "https://github.com/pasberth/necromancy"
  s.license = 'MIT'
  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.add_development_dependency "rspec"
end
