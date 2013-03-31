require 'slam'
require 'slam/ext'

module Slam

  module Ext::Or; extend Ext

    refine Dunk do
      public :|
    end
  end
end
