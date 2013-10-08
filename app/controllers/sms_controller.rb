require 'twilio-ruby'

class SmsController < ApplicationController

	def index		
		@body = params['message']
		@to = params['to']
		@client = Twilio::REST::Client.new(Rcplugin::TWILIO_ACCOUNT, Rcplugin::TWILIO_TOKENID)
		@account = @client.account
		@message = @account.sms.messages.create({:from => '+13125480077', :to => @to, :body => @body})					
		puts @message		
	end

end
