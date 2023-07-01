extends Node

var playerHP = 100
var playerGold = 0

func player_damage(damage):
	playerHP -= damage

func player_get_gold(gold):
	playerGold += gold
