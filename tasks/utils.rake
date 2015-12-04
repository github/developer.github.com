def config
  @config ||= symbolize_hash(YAML.load_file(File.join(File.dirname(__FILE__), '..', 'nanoc.yaml')))
end

def symbolize_hash(hash)
  JSON.parse(JSON[hash], symbolize_names: true)
end
