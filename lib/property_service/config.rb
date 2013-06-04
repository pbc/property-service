module PropertyService
  class Config

    attr_accessor :properties_source_json_file

    def self.instance
      @instance ||= new
    end

  end
end
