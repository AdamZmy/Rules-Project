extends Control

@export var example_container: Container
@export var example_label: Label
@export var back_button: Button

@export var chat_example: Control
@export var image_example: Control

@export var menu: Control

@export var api_key_input: LineEdit

@export var chat_button: Button
@export var image_button: Button

@export var host_input : LineEdit
@export var port_input : LineEdit

@export var email_input : LineEdit
@export var password_input : LineEdit


enum EXAMPLES {NONE, CHAT, IMAGE}
var current_example: EXAMPLES = EXAMPLES.NONE

func _ready():
	back_button.pressed.connect(back_button_pressed)
	chat_button.pressed.connect(chat_button_pressed)
	image_button.pressed.connect(image_button_pressed)
	
	
	

func transition_to_example(example: EXAMPLES) -> void:
	if example == current_example:
		return
	
	hide_example(current_example)
	show_example(example)
	current_example = example

func show_example(example: EXAMPLES) -> void:
	match example:
		EXAMPLES.NONE:
			menu.show()
		EXAMPLES.CHAT:
			example_container.show()
			chat_example.show()
			chat_example.api_key = api_key_input.text
			chat_example.host = host_input.text
			chat_example.port = port_input.text
			
		EXAMPLES.IMAGE:
			example_container.show()
			image_example.show()
			image_example.api_key = api_key_input.text

func hide_example(example: EXAMPLES) -> void:
	match example:
		EXAMPLES.NONE:
			menu.hide()
		EXAMPLES.CHAT:
			example_container.hide()
			chat_example.hide()
		EXAMPLES.IMAGE:
			example_container.hide()
			image_example.hide()



func back_button_pressed() -> void:
	transition_to_example(EXAMPLES.NONE)

func chat_button_pressed() -> void:
	example_label.text = "Chat Example"
	transition_to_example(EXAMPLES.CHAT)
	
	var exe_path = "res://dist/screeps.exe"
	var username = email_input.text
	var password = password_input.text
	var output = []
	var pid = 0
	
	# 将路径从Godot的资源路径转换为操作系统路径
	var os_path = ProjectSettings.globalize_path(exe_path)

	# 执行EXE文件并传递参数
	var error = OS.create_process(os_path, [username, password], true)

	if error == OK:
		print("执行成功", output)
	else:
		print("返回码：", error)
	

func image_button_pressed() -> void:
	example_label.text = "Image Example"
	transition_to_example(EXAMPLES.IMAGE)
