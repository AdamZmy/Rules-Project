extends Node

func save(content,file_path):
	var file = FileAccess.open("res://" + file_path + ".js", FileAccess.WRITE)
	file.store_string(content)
	file.close()
	
