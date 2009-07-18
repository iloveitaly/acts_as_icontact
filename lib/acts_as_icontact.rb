require 'rubygems'
require 'rest_client'
require 'json'

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'acts_as_icontact/exceptions'
require 'acts_as_icontact/config'
require 'acts_as_icontact/connection'
require 'acts_as_icontact/resource'
require 'acts_as_icontact/resource_collection'

# Load all of our resource files
Dir[File.join(File.dirname(__FILE__), 'acts_as_icontact', 'resources', '*.rb')].sort.each do |path|
  filename = File.basename(path, '.rb')
  require "acts_as_icontact/resources/#{filename}"
end

module ActsAsIcontact
end
