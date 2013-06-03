require 'bacon'

if defined?(RSpec)
  RSpec.configure do |config|
    config.mock_framework = :mocha
  end
else
  require 'mocha-on-bacon'
end

Bacon.summary_at_exit

require 'set'

ENV['SPEC'] = '1'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'kicker'

class File
  class << self
    attr_accessor :existing_files
    attr_accessor :use_original_exist
    
    alias exist_without_stubbing? exist?
    def exist?(file)
      if use_original_exist
        exist_without_stubbing?(file)
      else
        if existing_files
          existing_files.include?(file)
        else
          raise "Please stub the files you want to exist by setting File.existing_files"
        end
      end
    end
  end
end

File.use_original_exist = true
