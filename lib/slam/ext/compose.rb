require 'slam'
require 'slam/ext'

module Slam

  module Ext::Compose; extend Ext

    refine Dunk do

      public :>>
    end
  end
end
