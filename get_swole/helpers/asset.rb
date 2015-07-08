module GetSwole
  module Helpers
    module Asset
      def self.included(base)
        class << base
          attr_accessor :assets
        end

        base.assets = Assets.new
        base.run base.assets.prefix, base.assets
      end

      def asset_url(asset)
        self.class.assets.url_for(asset)
      end
    end
  end
end
