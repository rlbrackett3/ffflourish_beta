module Fog
  module Linode
    class DNS < Fog::Service

      requires :linode_api_key
      recognizes :port, :scheme, :persistent

      model_path 'fog/linode/models/dns'

      request_path 'fog/linode/requests/dns'
      request :domain_create
      request :domain_delete
      request :domain_list
      request :domain_update
      request :domain_resource_create
      request :domain_resource_delete
      request :domain_resource_list
      request :domain_resource_update

      class Mock

        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {}
          end
        end

        def self.reset_data(keys=data.keys)
          for key in [*keys]
            data.delete(key)
          end
        end

        def initialize(options={})
          @linode_api_key = options[:linode_api_key]
          @data = self.class.data[@linode_api_key]
        end

      end

      class Real

        def initialize(options={})
          require 'json'
          @linode_api_key = options[:linode_api_key]
          @host   = options[:host]    || "api.linode.com"
          @port   = options[:port]    || 443
          @scheme = options[:scheme]  || 'https'
          @connection = Fog::Connection.new("#{@scheme}://#{@host}:#{@port}", options[:persistent])
        end

        def reload
          @connection.reset
        end

        def request(params)
          params[:query] ||= {}
          params[:query].merge!(:api_key => @linode_api_key)

          response = @connection.request(params.merge!({:host => @host}))

          unless response.body.empty?
            response.body = JSON.parse(response.body)
            if data = response.body['ERRORARRAY'].first
              error = case data['ERRORCODE']
              when 5
                Fog::Linode::DNS::NotFound
              else
                Fog::Linode::DNS::Error
              end
              raise error.new(data['ERRORMESSAGE'])
            end
          end
          response
        end

      end
    end
  end
end
