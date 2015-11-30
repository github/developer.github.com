# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

require 'nanoc-html-pipeline'
require 'extended-markdown-filter'
require 'page-toc-filter'
require 'html/pipeline/rouge_filter'

include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Blogging
include ChangesHelper
