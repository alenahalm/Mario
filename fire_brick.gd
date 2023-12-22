extends AnimatableBody2D


var is_jumping = false
var cur_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	cur_pos = self.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_jumping:
		if cur_pos - self.position.y < 20: 
			self.position.y -= 5
		else:
			is_jumping = false
	elif cur_pos - self.position.y != 0:
		self.position.y += 5


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		is_jumping = true
