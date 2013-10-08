require 'the_city'

class StaticController < ApplicationController

  skip_before_filter :verify_authenticity_token

	def index

    #Decrypt encrypted JSON string from The City
    json = TheCityoAuth::Plugin::decrypt_city_data(params['city_data'],
                                                   params['city_data_iv'],
                                                   Rcplugin::THE_CITY_SECRET[0,32])

    #Convert json to Ruby hash
    @data = JSON.restore(json)
    @subdomain = @data['subdomain']
    @token = @data['oauth_token']

    #Create client
    @client = TheCity::API::Client.new do |config|
      config.app_id        = Rcplugin::THE_CITY_APP_ID
      config.app_secret    = Rcplugin::THE_CITY_SECRET
      config.access_token  = @token
      config.subdomain     = @subdomain
    end

    @me = @client.me
    @name = @me.name

  end
end