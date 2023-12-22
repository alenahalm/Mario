extends CharacterBody2D

var health = 5
var is_invincible = false
var score = 0
var coins = 0
var end = false
const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")

func _ready():
	health = Global.health
	score = Global.score
	self.global_position.x = Global.position_x
	self.global_position.y = Global.position_y

func _physics_process(delta):
	
	if Global.pause:
		return
	Global.score = score
	Global.position_x = self.global_position.x
	Global.position_y = self.global_position.y
	Global.health = health
	
	if self.position.y > 5000:
		health -= 5

	if health == 10:
		change_scale(1)
	if health == 5:
		change_scale(0.7)
	if health == 0:
		Global.reset()
		get_tree().change_scene_to_file("res://game_over.tscn")
	elif !self.end:
	
	# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta * 1.2

		# Handle Jump.
		if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and is_on_floor():
			velocity.y += JUMP_VELOCITY
			anim.play("Jump")

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction == 1:
			get_node("AnimatedSprite2D").flip_h = false
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				anim.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				anim.play("Idle")
		if velocity.y > 0:
			anim.play("Fall")
	else:
		anim.play("Run")
		velocity.x = SPEED

	move_and_slide()

func make_invincible():
	is_invincible = true
	for i in 4:
		self.modulate.a = 0.5
		await get_tree().create_timer(0.5).timeout
		self.modulate.a = 1
		await get_tree().create_timer(0.5).timeout
	is_invincible = false

func change_scale(scale):
	get_node("AnimatedSprite2D").scale.x = scale
	get_node("AnimatedSprite2D").scale.y = scale
	get_node("CollisionShape2D").scale.x = scale
	get_node("CollisionShape2D").scale.y = scale
