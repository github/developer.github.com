module Ethon
  class Easy

    # This module contains the logic and knowledge about the
    # available options on easy.
    module Options
      attr_reader :url

      def url=(value)
        @url = value
        Curl.set_option(:url, value, handle)
      end
      
      Curl.easy_options.each do |opt,props|
        eval %Q<
          def #{opt}=(value)
            Curl.set_option(:#{opt}, value, handle)
            value
          end
        > unless method_defined? opt.to_s+"="
        if props[:type]==:callback then
          eval %Q<
            def #{opt}(&block)
              @procs ||= {}
              @procs[:#{opt}]=block
              Curl.set_option(:#{opt}, block, handle)
              nil
            end
          > unless method_defined? opt.to_s
        end
      end
    end
  end
end
