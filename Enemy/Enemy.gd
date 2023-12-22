extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var go_left = true
var is_dying = false


func _ready():
	get_node("AnimatedSprite2D").play("Run")

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if !is_dying:
		get_node("AnimatedSprite2D").play("Run")
	get_node("AnimatedSprite2D").flip_h = !go_left
	if go_left:
		velocity.x = SPEED
	else:
		velocity.x = -SPEED
	if is_dying:
		velocity.x = 0
	move_and_slide()

func _on_side_collision_body_entered(body):
	if body.name == "Player" and !is_dying and !body.is_invincible:
		body.health -= 5
		body.make_invincible()
	else:
		go_left = !go_left


func _on_top_collision_body_entered(body):
	if body.name == "Player":
		death()

func death():
	is_dying = true
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
