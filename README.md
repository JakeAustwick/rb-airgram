#Ruby AirGram Client

This is an **unofficial** wrapper for the [AirGram](http://www.airgramapp.com/) notifications service. It provides a wrapper to interact with both the guest and the authenticated methods.

###Installation

```gem install rb-airgram```

###Usage

You can either initialize the client with the username and password set, or if you are only planning on using the guest sending function, you can initialize it with no parameters.

```ruby
require 'airgram'

# Without authentication
client = Airgram.new

# Send a notificiation with no authentication needed (url is optional)
client.send_as_guest("recipient@email.com", "Some awesome message", "http://www.bbc.com")

# Auth needed for below functions
# Username = Service Key
# Password = Service Secret
client = Airgram.new(:username => "XXXX", :password => "XXXX")

# Subscribe a new user
client.subscribe("recipient@email.com")

# Send notification to subscribed user (url is optional)
client.send("recipient@email.com", "Some awesome message", "http://www.bbc.com")

# Send notification to EVERY subscribed user (url is optional)
client.broadcast("Some awesome message", "http://www.bbc.com")
```
See [AirGram API Docs](http://www.airgramapp.com/docs) for more information.

All methods return either true / false depending on whether the notification request succeeds.