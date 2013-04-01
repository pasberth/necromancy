require 'slam'

class ApplicativeDunk < Slam::Dunk
  include ::Slam::Applicative
end

describe ApplicativeDunk do

  let(:l) { described_class.new }
end
