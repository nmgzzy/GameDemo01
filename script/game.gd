extends Node

var playerHP = 100
var playerGold = 0
var playerCherry = 0


func player_damage(damage):
	if playerHP >= damage:
		playerHP -= damage
	else:
		playerHP = 0

func player_get_gold(gold):
	playerGold += gold
	
func player_get_cherry(cherry):
	playerCherry += cherry
