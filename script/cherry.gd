extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play('idle')


func _on_area_2d_body_entered(body):
	if body.name == 'player':
		Game.player_get_cherry(1)
		Utils.save_game()
		queue_free()
