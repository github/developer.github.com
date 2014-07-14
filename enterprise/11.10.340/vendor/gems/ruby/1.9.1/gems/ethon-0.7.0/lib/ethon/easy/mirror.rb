module Ethon
  class Easy
    class Mirror
      attr_reader :options
      alias_method :to_hash, :options

      def self.informations_to_mirror
        Informations::AVAILABLE_INFORMATIONS.keys +
          [:return_code, :response_headers, :response_body, :debug_info]
      end

      def self.informations_to_log
        [:url, :response_code, :return_code, :total_time]
      end

      def self.from_easy(easy)
        options = {}
        informations_to_mirror.each do |info|
          options[info] = easy.send(info)
        end
        new(options)
      end

      def initialize(options = {})
        @options = options
      end

      def log_informations
        Hash[*self.class.informations_to_log.map do |info|
          [info, options[info]]
        end.flatten]
      end

      informations_to_mirror.each do |info|
        eval %Q|def #{info}; options[#{info}]; end|
      end
    end
  end
end
