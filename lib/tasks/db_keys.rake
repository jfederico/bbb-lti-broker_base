require 'bbb_lti_broker/helpers'
include BbbLtiBroker::Helpers

namespace :db do
  namespace :keys do
    desc "Add a new blti keypair ('rake db:keys:add[key:secret]')"
    task :add, :keys do |t, args|
      begin
        Rake::Task['environment'].invoke
        ActiveRecord::Base.connection
        blti_keys = BbbLtiBroker::Helpers.string_to_hash(args[:keys] || '')
        if blti_keys.empty?
          puts "No keys provided"
          exit 1
        end
        blti_keys.each do |key, secret|
          puts "Adding '#{key}=#{secret}'"
          tool = RailsLti2Provider::Tool.find_by(uuid: key, lti_version: 'LTI-1p0', tool_settings:'none')
          if tool
            puts "Key '#{key}' already exists, it can not be added"
          else
            RailsLti2Provider::Tool.create!(uuid: key, shared_secret: secret, lti_version: 'LTI-1p0', tool_settings:'none')
          end
        end
      rescue => exception
        puts exception.backtrace
        exit 1
      end
    end

    desc "Update an existent blti keypair if exists ('rake db:keys:update[key:secret]')"
    task :update, :keys do |t, args|
      begin
        Rake::Task['environment'].invoke
        ActiveRecord::Base.connection
        blti_keys = BbbLtiBroker::Helpers.string_to_hash(args[:keys] || '')
        if blti_keys.empty?
          puts "No keys provided"
          exit 1
        end
        blti_keys.each do |key, secret|
          tool = RailsLti2Provider::Tool.find_by(uuid: key, lti_version: 'LTI-1p0', tool_settings:'none')
          if !tool
            puts "Key '#{key}' does not exist, it can not be updated"
          else
            tool.update!(shared_secret: secret)
            puts "Updated '#{key}=#{secret}'"
          end
        end
      rescue => exception
        puts exception.backtrace
        exit 1
      end
    end

    desc "Delete an existent blti keypair if exists ('rake db:keys:delete[key:secret]'')"
    task :delete, :keys do |t, args|
      begin
        Rake::Task['environment'].invoke
        ActiveRecord::Base.connection
        blti_keys = BbbLtiBroker::Helpers.string_to_hash(args[:keys] || '')
        if blti_keys.empty?
          puts "No keys provided"
          exit 1
        end
        blti_keys.each do |key, secret|
          tool = RailsLti2Provider::Tool.find_by(uuid: key, lti_version: 'LTI-1p0', tool_settings:'none')
          if !tool
            puts "Key '#{key}' does not exist, it can not be deleted"
          else
            tool.delete
            puts "Deleted '#{key}=#{secret}'"
          end
        end
      rescue => exception
        puts exception.backtrace
        exit 1
      end
    end

    desc "Show an existent blti keypair if exists ('rake db:keys:show[key:secret]')"
    task :show, :keys do |t, args|
      begin
        Rake::Task['environment'].invoke
        ActiveRecord::Base.connection
        blti_keys = BbbLtiBroker::Helpers.string_to_hash(args[:keys] || '')
        if blti_keys.empty?
          puts "No keys provided"
          exit 1
        end
        blti_keys.each do |key, secret|
          tool = RailsLti2Provider::Tool.find_by(uuid: key, lti_version: 'LTI-1p0', tool_settings:'none')
          if !tool
            puts "Key '#{key}' does not exist, it can not be shown"
          else
            puts "'#{tool.uuid}=#{tool.shared_secret}'"
          end
        end
      rescue => exception
        puts exception.backtrace
        exit 1
      end
    end

    desc "Delete all existent blti keypairs"
    task :deleteall do
      begin
        Rake::Task['environment'].invoke
        ActiveRecord::Base.connection
        puts "Deleting all LTI-1p0 keys"
        RailsLti2Provider::Tool.delete_all(lti_version: 'LTI-1p0', tool_settings:'none')
      rescue => exception
        puts exception.backtrace
        exit 1
      end
    end

    desc "Show all existent blti keypairs"
    task :showall do
      begin
        Rake::Task['environment'].invoke
        ActiveRecord::Base.connection
        blti_keys = RailsLti2Provider::Tool.all
        blti_keys.each do |key|
          puts "'#{key.uuid}=#{key.shared_secret}'"
        end
      rescue => exception
        puts exception.backtrace
        exit 1
      end
    end

  end
end
