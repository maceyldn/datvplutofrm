# About MQTT in PlutoDVB

MQTT stands for Message Queuing Telemetry Transport. It is a lightweight publish and subscribe system where you can publish and receive messages as a client. MQTT is a simple messaging protocol, designed for constrained devices with low-bandwidth. So, it's the perfect solution for Internet of Things applications.

MQTT is implemented in PlutoDVB for instant communication needs of the human-machine interface with the Pluto core. A MQTT mosquitto brocker is implemented, communicating by websocket ```9001``` or directly on ```8883``` port.

This allows the parameters changed by the operator to be taken into account without delay, on the fly.

## Implemented messages 

- ``` plutodvb/var``` All the variables available on a page are sent in the following form ``` { "id or name" : value }```
	-  ```{"fec":"13"}``` Ask to change FEC to 1/3
	-  ```{"ptt":"false"}``` Ask to stop transmission (Not implemented yet)
	-  ```{"ptt":"true"}``` Ask to go to transmission (Not implemented yet)	
	-  ```{"page":"setup.php"}``` Tell the user is (re)load this page, or client is reconnected
	-  ```{"file_firm":"C:\fakepath\pluto.frm"}``` A firmware file is uploaded	
- ``` plutodvb/subvar/VAR``` All variables VAR are transmit with raw value (no json format).  You can change value from external software to plutoDVB (display is also updated, but only on the active modulator tab - it can be changed by piloting (see tab_to_activate)). Change of checkbox is made by {false,true} values.
- ``` plutodvb/started``` true false Sent by the PlutoDVB when is started
- ``` plutodvb/status/tx``` Transmiting status : true = On air, false = Stand by
- ``` plutodvb/status/adtemp``` ADC Temperature
- ``` plutodvb/status/fpgatemp``` FPGA Temperature
- ``` plutodvb/status/voltage``` Input voltage (V)
- ``` plutodvb/status/current``` Input current (mA)
- ``` plutodvb/ts/netbitrate``` Transport Stream Bitrate in bits/s
- ``` plutodvb/status/ts/bufferstate```   [Nominal,Underflow,Overflow]
- ``` plutodvb/status/ts/bufferfill```   Buffer filling (quantity of bytes in buffer)
- ``` plutodvb/status/ts/bufferoverflow```  Buffer overflow level (in millisec)
- ``` plutodvb/subvar/textgen``` Text generator string (can be used as a text banner for video - textgen.php page must be displayed)
- ``` plutodvb/textgen/updaterequest```  Request an update of generated text (textgen.php page must be displayed)
- ``` plutodvb/modulator/tab_to_activate```  [n integer 1.. ] display one of the modulator tabs of the controller page (simulates a click on the tab at position n)
- ``` plutodvb/modulator/apply```  With controler page opened, apply active modulator settings from external software


## H265 Patch Box
- ``` h265coder/request_status``` 
- ``` h265coder/codec``` {h264,h265}
- ``` h265coder/stattime``` Window time(ms) for statistical bitrate
- ``` h265coder/bitrate``` Video bitrate
- ``` h265coder/framerate``` Video Framerate
- ``` h265coder/gop``` GOP (in frames)
- ``` h265coder/fluctuation``` 0 (automatic) 1(Low quality , no bitrate fluctuation)-4(High quality, but variable - ``` bitrate)
- ``` h265coder/qpdelta```
- ``` h265coder/maxqp```
- ``` h265coder/minqp```
- ``` h265coder/level``` [1,5] //A smaller value indicates better quality.
- ``` h265coder/mqpdelta```
- ``` h265coder/aspect_ratio``` 16x9 : force aspect ratio 
- ``` h265coder/lost_strategy``` Skip strategy : bitrate threeshold to skip picture

We advise the use of [MQTT Explorer](http://mqtt-explorer.com/) to observe the exchanged variables.

# Feedbacks and discussions
https://groups.io/g/plutodvb
