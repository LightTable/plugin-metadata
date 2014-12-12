#!/usr/bin/env ruby

require 'open-uri'
require 'edn'
require 'json'

def process_args(argv)
  unless argv.size >= 2
    $stderr.puts "#{$0} GITHUB_URL VERSION [--commit]"
    exit 1
  end

  unless argv[1] =~ /^\d\.\d\.\d$/
    $stderr.puts "Invalid version. Version must be in the format X.X.X e.g. 0.1.2."
    exit 1
  end
  argv
end

def get_plugin(github_url, version)
  base_url = "#{github_url.sub('github.com', 'raw.githubusercontent.com')}/#{version}"
  ["plugin.edn", open("#{base_url}/plugin.edn").read]
rescue OpenURI::HTTPError
  begin
    ["plugin.json", open("#{base_url}/plugin.json").read]
  rescue OpenURI::HTTPError
    $stderr.puts "No plugin.edn or plugin.json exists for that version. Make sure the repository has a tag for that version."
    exit 1
  end
end

def extract_name(filename, plugin_body)
  if filename == 'plugin.json'
    JSON.parse(plugin_body)['name']
  else
    EDN.read(plugin_body)[:name]
  end
end

def add_new_file(plugin_name, version, plugin_body, filename)
  system("mkdir -p #{plugin_name}/#{version}")
  File.open("#{plugin_name}/#{version}/#{filename}", 'w') { |f| f.write(plugin_body) }
  "#{plugin_name}/#{version}/#{filename}"
end

github_url, version = process_args(ARGV)
plugin_filename, plugin_body = get_plugin(github_url, version)
plugin_name = extract_name(plugin_filename, plugin_body)
full_path = add_new_file(plugin_name, version, plugin_body, plugin_filename)

if ARGV.include?('--commit')
  system("git add #{full_path}")
  system("git commit -m 'Add #{plugin_name} #{version}'")
end
