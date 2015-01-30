#!/usr/bin/env ruby

# Verifies if paths are in the correct name directory

require 'edn'
require 'json'

def validate_paths(paths, extract_name_fn)
  paths.group_by {|path| path[%r{^[^/]+}] }.each do |actual, paths|
    # Only check latest version since previous versions may have had another name
    # e.g. color_picker -> Color Picker
    latest_version_path = paths.sort.last
    expected = extract_name_fn.call(File.read(latest_version_path))
    if expected != actual
      puts "Plugin '#{expected}' is at an invalid path: #{latest_version_path}"
    end
  end
end

validate_paths Dir.glob('**/*.edn'), lambda {|e| EDN.read(e)[:name] }
validate_paths Dir.glob('**/*.json'), lambda {|e| JSON.parse(e)['name'] }
