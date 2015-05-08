#!/usr/bin/env ruby

require "thor"
require "json"

class CLI < Thor
    desc "version catalog.box", "Adds version to catalog"
    option :version, :required => true, :type => :string, :aliases => "-v"
    option :url, :required => true, :type => :string, :aliases => "-u"
    option :checksum_type, :required => true, :type => :string, :aliases => "-t"
    option :checksum, :required => true, :type => :string, :aliases => "-c"
    def version(catalog)
        file = File.read(catalog)
        data_hash = JSON.parse(file)
        data_hash["versions"] << { 
            version: options[:version],
            providers: [
                {
                    name: "virtualbox",
                    url: options[:url],
                    checksum_type: options[:checksum_type],
                    checksum: options[:checksum]
                }
            ]
        }

        File.open(catalog, 'w') { |f| f.write(JSON.pretty_generate(data_hash)) }

        puts "Added version %s" % [ options[:version] ]
    end

    desc "create catalog.box", "Creates an empty catalog"
    option :name, :required => true, :type => :string, :aliases => "-n"
    option :description, :required => true, :type => :string, :aliases => "-d"
    def create(catalog)
        data_hash = {
            name: options[:name],
            description: options[:description],
            versions: []
        }

        File.open(catalog, 'w') { |f| f.write(JSON.pretty_generate(data_hash)) }
        puts "Created catalog for '%s'" % [ options[:name] ]
    end
end

CLI.start
