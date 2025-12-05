module MyDovhyiApp
  class Configurator
    attr_reader :config

    def initialize
      @config = {
        run_website_parser: 1,
        run_save_to_csv: 1,
        run_save_to_json: 1,
        run_save_to_yaml: 1
      }
    end
  end
end
