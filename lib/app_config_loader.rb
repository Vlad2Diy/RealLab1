require 'yaml'
require 'erb'
require 'json'

module MyDovhyiApp
  class AppConfigLoader
    attr_reader :config_data

    def initialize
      @config_data = {}
    end

    def config(main_config_file, yaml_dir)
      load_default_config(main_config_file)
      load_additional_configs(yaml_dir)
      yield(@config_data) if block_given?
      @config_data
    end

    def load_libs
      @loaded_libs ||= []
      system_libs = ['date', 'json', 'yaml', 'erb']
      system_libs.each { |lib| require lib }

      Dir.glob('libs/**/*.rb').each do |file|
        next if @loaded_libs.include?(file)
        require_relative "../#{file}"
        @loaded_libs << file
      end
    end

    def pretty_print_config_data
      puts JSON.pretty_generate(@config_data)
    end

    private

    def load_default_config(file)
      erb = ERB.new(File.read(file))
      @config_data.merge!(YAML.safe_load(erb.result))
    end

    def load_additional_configs(dir)
      Dir.glob("#{dir}/*.yaml").each do |file|
        @config_data.merge!(YAML.safe_load(File.read(file)))
      end
    end
  end
end
