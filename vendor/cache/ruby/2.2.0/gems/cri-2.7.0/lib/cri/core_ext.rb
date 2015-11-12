# encoding: utf-8

module Cri
  module CoreExtensions
  end
end

require 'cri/core_ext/string'

class String
  include Cri::CoreExtensions::String
end
