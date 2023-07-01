extends Node2D

func _ready():
	Utils.load_game()
	Game.playerHP = 100

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://nodes/world.tscn")
