extends HTTPRequest



var api_url = "https://screeps.com/api/auth/signin"
var body = {
	"email": "13501355311@126.com",
	"password": "Ucla0916"
}

func _ready():
	request_completed.connect(on_request_completed)
	var header = ["Content-Type: application/json", "Authorization: Bearer "]
	var body_json = JSON.new().stringify(body)
	
	var error: Error = request(api_url,[] , HTTPClient.METHOD_POST, body_json)
	
	pass

func on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	print("ON REQUEST COMPLETE")
	print(result)
	
	var json: JSON = JSON.new()
	# Parse the received response body.
	var error: Error = json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	
	var failed: bool = false
	
	print(response)
	
	pass
