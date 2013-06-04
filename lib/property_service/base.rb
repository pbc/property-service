module PropertyService
  class Base
    class << self
      def configure(&block)
        class_eval(&block)
      end

      def config
        PropertyService::Config.instance
      end
    end
  end
end