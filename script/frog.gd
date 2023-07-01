extends CharacterBody2D

enum {IDLE, CHASEING, DEAD}

const SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = IDLE

@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += delta * gravity
		
	match state:
		IDLE:
			anim.play("idle")
			velocity.x = 0
		CHASEING:
			anim.play("jump")
			var player = get_node("../../players/player")
			var dir = (player.position - self.position).normalized()
			anim.flip_h = (dir.x > 0)
			velocity.x = dir.x * SPEED
		DEAD:
			anim.play("death")
		
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "player":
		state = CHASEING

func _on_player_detection_body_exited(body):
	if body.name == "player":
		state = IDLE

func _on_frog_death_body_entered(body):
	if body.name == "player":
		frog_death(0)

func _on_frog_damage_body_entered(body):
	if body.name == "player":
		frog_death(10)

func frog_death(damage):
	state = DEAD
	var player = get_node("../../players/player")
	player.player_pop(position)
	Game.player_damage(damage)
	Game.player_get_gold(5)
	Utils.save_game()
	await anim.animation_finished
	queue_free()
