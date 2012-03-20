require 'httparty'

class Airgram
  class AuthenticationError < StandardError
  end
  include HTTParty
  base_uri "https://api.airgramapp.com/1"

  def initialize(auth={})
    @auth = auth
  end

  def send_as_guest(email, msg, url=nil)
    request_successful?( post("/send_as_guest", :email => email, :msg => msg, :url => url) )
  end

  def subscribe(email)
    check_auth_details!
    request_successful?( post("/subscribe", {:email => email}, @auth) )
  end

  def send(email, msg, url=nil)
    check_auth_details!
    request_successful?( post("/send", {:email => email, :msg => msg, :url => url}, @auth) )
  end

  def broadcast(msg, url=nil)
    check_auth_details!
    request_successful?( post("/broadcast", {:msg => msg, :url => url}, @auth) )
  end

private

  # Internal: Fire POST HTTP request.
  def post(path, params = {}, auth=nil)
    request(:post, path, :body => params, :basic_auth => @auth)
  end

  # Internal: Does the actual requests.
  def request(method, path, params)
    self.class.send(method, path, params)
  end

  def request_successful?(response)
    response.code == 200
  end

  def check_auth_details!
    unless @auth.has_key?(:username) && @auth.has_key?(:password)
      raise AuthenticationError, "Calling a method that requires authentication with no Service Key or Service Secret!"
    end
  end
end

client = Airgram.new()
p client.send_as_guest("contact@mumbodesign.com", "s there")