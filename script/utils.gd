extends Node

const SAVE_PATH = "user://save.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGold": Game.playerGold,
	}
	var jstr = JSON.stringify(data)
	file.store_string(jstr)
	
func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if not file.eof_reached():
			var jstr = file.get_line()
			var jdata = JSON.parse_string(jstr)
			if jdata:
				Game.playerHP = jdata["playerHP"]
				Game.playerGold = jdata["playerGold"]
