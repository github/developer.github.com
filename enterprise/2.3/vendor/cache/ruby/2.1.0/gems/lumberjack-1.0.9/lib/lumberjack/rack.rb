module Lumberjack
  module Rack
    autoload :UnitOfWork, File.expand_path("../rack/unit_of_work.rb", __FILE__)
  end
end
