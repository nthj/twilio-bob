DIAL = <<-DIAL
Dial "0345#" and I'll try to let you in. (I'm a pretty clever robot.)
DIAL

BOB = <<-BOB
Hello, I'm Bob. I'm Lindsey and Nathaniel's robot that will help you with directions to their apartment.

First, park outside the front (north side) of REDACTED (dun dun dun.) It's a circular drive. #{DIAL}

Once you're inside the front door, go straight, towards the gym. Turn left. Go through the double doors. Turn right. Walk through the outside common area and straight up the stairs. Turn left. Walk to the end of the hallway. Turn right. Up all the stairs!

Head straight down the hallway until it curves right. Our doormat is brown with "1s" and "0s."
BOB

class Bob < Sinatra::Base
  post '/' do
    Twilio::TwiML::Response.new do |r|
      r.Message(from: '+15122715352', to: "#{params['Body']}".strip) do |message|
        if (9...21) === Time.zone.now.hour
          message.Body BOB.gsub(DIAL, '')
        else
          message.Body BOB
        end
      end
      r.Message(from: '+15122715352', to: "#{params['From']}".strip) do |message|
        message.Body "Thanks guys, I sent #{params['Body']} directions. - Bob"
      end
    end.text
  end
end

