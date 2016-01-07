require 'json'
require 'active_support/core_ext/hash'

def config
  @config ||= symbolize_hash(YAML.load_file(File.join(File.dirname(__FILE__), '..', 'nanoc.yaml')))
end

def symbolize_hash(hash)
  hash.deep_symbolize_keys
end

