require 'securerandom'
require 'jwt'
require 'json'
require 'faraday'
require 'bitzlato'

module Bitzlato
  class Client
    class Error < StandardError; end
    WrongResponse = Class.new Error

    def initialize(home_url: , key: , logger: false, email: nil, uid: nil, adapter: nil)
      raise ArgumentError, 'email or uid must be presented' if uid.nil? && email.nil?
      @email = email
      @uid = uid
      @jwk = JWT::JWK.import key
      @home_url = home_url
      @adapter = adapter || Faraday.default_adapter
      if logger == true
        @logger = Faraday::Response::Logger.new(STDOUT)
      else
        @logger = logger
      end
    end

    def get(path, params = {})
      parse_response connection.get path, params
    end

    def post(path, params = {})
      parse_response connection.post path, params.to_json
    end

    private

    def parse_response(response)
      raise WrongResponse, "Wrong response status (#{response.status})" unless response.success?
      raise WrongResponse, "Wrong content type (#{response['content-type']})" if !response.body.blank? && response['content-type'] != 'application/json'
      JSON.parse response.body
    end

    def claims
      {
        "aud": "usr",
        "iat": Time.now.to_i,
        "jti": SecureRandom.hex(10)
      }.tap { |c|
        c['uid'] = @uid unless @uid.nil?
        c['email'] = @email unless @email.nil?
      }
    end

    def connection
      @connection ||= Faraday.new url: @home_url do |c|
        c.use Faraday::Response::Logger unless @logger.nil?
        c.headers = {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
        c.request :curl, logger, :warn if ENV['BITZLATO_CURL_LOGGER']
        c.authorization :Bearer, bearer
        c.adapter @adapter
      end
    end

    def bearer
      JWT.encode claims, @jwk.keypair, 'ES256', kid: '1'
    end
  end
end
