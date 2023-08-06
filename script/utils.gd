extends Node

const SAVE_PATH = "res://save.bin" # "user://save.bin"

func save_game():
	var Saved_data_dic: Dictionary = {
		"playerHP": Game.playerHP,
		"playerGold": Game.playerGold,
		"playerCherry": Game.playerCherry,
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var jstr = JSON.stringify(Saved_data_dic)
	file.store_string(jstr)
	
func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if not file.eof_reached():
			var jstr = file.get_line()
			var jdata = JSON.parse_string(jstr)
			if jdata:
				#for i in Saved_data_dic:
				#	Saved_data_dic[i] = jdata[i]
				Game.playerHP = jdata["playerHP"]
				Game.playerGold = jdata["playerGold"]
				Game.playerCherry = jdata["playerCherry"]
				
	
