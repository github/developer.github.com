# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'nanoc-conref-fs'

require 'nanoc-html-pipeline'
require 'extended-markdown-filter'
require 'page-toc-filter'
require 'html/pipeline/rouge_filter'

include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Blogging
include ChangesHelper

Nanoc::Helpers::Rendering.module_eval do
  if respond_to? :render
    alias_method :renderp, :render
    remove_method :render
  end
end
