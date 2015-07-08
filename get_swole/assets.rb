module GetSwole
  class Assets
    def initialize
      preload_assets
    end

    def sprockets_env
      return @sprockets_env if @sprockets_env
      env = Sprockets::Environment.new
      env.js_compressor = :uglifier if GetSwole.production?
      env.append_path 'assets/js'
      env.append_path 'assets/css'
      env.append_path 'assets/vendor'
      @sprockets_env = GetSwole.production? ? env.index : env
    end

    def url_for(asset)
      raise %(No such asset: "#{asset}") unless sprockets_env[asset]
      [asset_host, prefix, asset_path(asset)].join("/")
    end

    def call(env)
      sprockets_env.call(env)
    end

    def prefix
      "get"
    end

    private

    def asset_path(asset)
      if GetSwole.production?
        sprockets_env[asset].digest_path
      else
        sprockets_env[asset].logical_path.to_s
      end
    end

    def asset_host
      ENV['ASSET_HOST']
    end

    def preload_assets
      return unless GetSwole.production?
      url_for('swole.css')
      url_for('swole.js')
    end
  end
end
