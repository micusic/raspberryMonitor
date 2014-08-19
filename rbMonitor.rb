require 'pi_piper'
require 'facepp'

include PiPiper

IMAGE_DIRECTORY="/home/pi/test"
api = FacePP.new '79467077fde305ede39bf25fb910eadd', '10w5PmBpaWUfi-z7S0dYmKwPaNQFmVJP'

def detect_face file
  result = api.detection.detect img: file
  if result['session_id']
    `mv #{file} result['session_id'].jpg`
  end
end


after :pin => 23, :goes => :high do
	f = File.open("log_piper.txt", "a")
	f.puts(Time.now.to_s)
	f.close

  file_name = "#{IMAGE_DIRECTORY}/person-#{Time.now.to_i}.jpg"
	`sudo fswebcam #{file_name}`
	`curl --request POST --data-binary @"ci"#{file_name}" --header "U-ApiKey: 824d86075f2b76ea2299951233a53528" http://api.yeelink.net/v1.1/device/13547/sensor/22418/datapoints`
  detect_face file_name
        puts "++++++++++++++"
        puts Time.now.to_s
        puts "++++++++++++++"
end

PiPiper.wait
