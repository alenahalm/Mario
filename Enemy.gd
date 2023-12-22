extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var go_left = true
var is_dying = false
var index = 0

func _ready():
	get_node("AnimatedSprite2D").play("Run")
	if self.name.substr(5) == "":
		index = 0
	else:
		index = int(self.name.substr(4))
	if Global.enemies_x[index] + Global.enemies_y[index] != 0:
		self.global_position.x = Global.enemies_x[index]
		self.global_position.y = Global.enemies_y[index]

func _physics_process(delta):
	
	Global.enemies_x[index] = self.global_position.x
	Global.enemies_y[index] = self.global_position.y
	
	if Global.pause:
		return
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
		body.score += 100
		death()

func death():
	is_dying = true
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	Global.enemies_x[index] = -100
	Global.enemies_y[index] = -100
	self.queue_free()
