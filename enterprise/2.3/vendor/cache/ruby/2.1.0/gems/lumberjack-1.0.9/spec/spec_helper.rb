require File.expand_path("../../lib/lumberjack.rb", __FILE__)
require 'stringio'
require 'fileutils'

def tmp_dir
  File.expand_path("../tmp", __FILE__)
end

def create_tmp_dir
  FileUtils.rm_r(tmp_dir) if File.exist?(tmp_dir)
  FileUtils.mkdir_p(tmp_dir)
end

def delete_tmp_dir
  FileUtils.rm_r(tmp_dir)
end