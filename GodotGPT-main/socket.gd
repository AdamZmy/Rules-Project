extends HTTPRequest



var api_url = "https://screeps.com/api/auth/signin"
var body = {
	"email": "13501355311@126.com",
	"password": "Ucla0916"
}

var token 

func _ready():
	request_completed.connect(on_request_completed)
	var headers = ["Content-Type: application/json"]
	var body_json = JSON.new().stringify(body)
	
#	print()
#	request_console()
	var error: Error = request(api_url, headers , HTTPClient.METHOD_POST, body_json)
	
	

func on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
#	print("ON REQUEST COMPLETE")
#	print(result)
	print("response_code:" , response_code)
	print("headers:", headers )
#	print("body:" , body)
	var json: JSON = JSON.new()
	# Parse the received response body.
	var error: Error = json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	
	var failed: bool = false
	
	print(response)
#	print("token : " , response["token"])
	if response["token"]:
		token = response["token"]
	
#	socket(token)
	
#	request_console(token)
#	request_console_post(token)
#	request_console_get(token)
	request_console_get_me(token)

func request_console_post(token):
	var api_url = "https://screeps.com/api/user/console?shard=shard3"
	var body = {
		"expression" : ""
	}
	var headers = ["X-Token: " + token, "X-Username: " + token]
	var body_json = JSON.new().stringify(body)
#	print()
	var error: Error = request(api_url, headers , HTTPClient.METHOD_POST, body_json)
	

func request_console_get(token):
	var api_url = "https://screeps.com/api/game/room-terrain?room=ROOM_NAME"
	var body ={
		"email": "13501355311@126.com",
		"password": "Ucla0916"
	}
	var headers = ["X-Token: " + token, "X-Username: " + token]
	var body_json = JSON.new().stringify(body)
	var error: Error = request(api_url, headers , HTTPClient.METHOD_GET, body_json)

func request_console_get_me(token):
	var api_url = "https://screeps.com/api/auth/me"
	var body ={
		"email": "13501355311@126.com",
		"password": "Ucla0916"
	}
	var headers = ["X-Token: " + token, "X-Username: " + token]
	var body_json = JSON.new().stringify(body)
	var error: Error = request(api_url, headers , HTTPClient.METHOD_GET, body_json)

func socket(token):
	var body = {"auth" :token}
	var body_json = JSON.new().stringify(body)
	var url = "wss://screeps.com/socket/333/88888888/websocket"
	var sock = WebSocketPeer.new()
	var error = sock.connect_to_url(url,body_json)
	
	if error != OK:
		print("SOCKET ERROR:  ", error)
		return error
	print("SOCKET OK")
	return OK
