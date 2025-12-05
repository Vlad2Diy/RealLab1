require 'yaml'

module MyDovhyiApp
  class AppConfigLoader
    CONFIG_ROOT = File.expand_path('../config/yaml_config', __dir__)

    def initialize
      @configs = load_all_configs
    end

    def get(key)
      @configs[key.to_s]
    end

    private

    def load_all_configs
      configs = {}
      Dir.glob(File.join(CONFIG_ROOT, '*.yaml')).each do |file|
        yaml = YAML.load_file(file)
        next unless yaml.is_a?(Hash)
        yaml.each { |k, v| configs[k.to_s] = v }
      end
      configs
    end
  end
end
