require 'the_city'
require 'rc_auth'
class StaticController < ApplicationController

  skip_before_filter :verify_authenticity_token

	def index
		json = RcAuth::decrypt_city_data(params['city_data'],params['city_data_iv'],Rcplugin::THE_CITY_SECRET[0,32])

		@data = JSON.restore(json)
		@subdomain = @data['subdomain']
		@token = @data['oauth_token']

		@client = TheCity::API::Client.new do |config|
			config.app_id = Rcplugin::THE_CITY_APP_ID
			config.app_secret = Rcplugin::THE_CITY_SECRET
			config.access_token = @token
			config.subdomain = @subdomain
		end

		@me = @client.me
		@name = @me.name

	end
end