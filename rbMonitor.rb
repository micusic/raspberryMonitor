require 'pi_piper'
include PiPiper

after :pin => 23, :goes => :high do
	f = File.open("log_piper.txt", "a")
	f.puts(Time.now.to_s)
	f.close
	`sudo fswebcam /tmp/shot.jpg`
	`curl --request POST --data-binary @"/tmp/shot.jpg" --header "U-ApiKey: 824d86075f2b76ea2299951233a53528" http://api.yeelink.net/v1.1/device/13547/sensor/22401/datapoints`
end

PiPiper.wait
