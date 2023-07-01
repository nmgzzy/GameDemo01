extends CharacterBody2D

const RESIST = 9.5
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
	else:
		if abs(velocity.x) <= RESIST:
			velocity.x = 0
		elif velocity.x > RESIST:
			velocity.x -= RESIST
		else:
			velocity.x += RESIST
		

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			anim.play("fall")
		else:
			anim.play("jump")
	#on floor
	else:
		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
		if direction:
			anim.play("run")
		else:
			anim.play("idle")

	if Game.playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://nodes/main.tscn")

	move_and_slide()

func player_pop(from_pos):
	var v = (from_pos - self.position).normalized()
	velocity.x = v.x * JUMP_VELOCITY
	velocity.y = v.y * JUMP_VELOCITY
	
