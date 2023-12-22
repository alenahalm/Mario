extends AnimatableBody2D

var counter = 0
var cur_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	cur_pos = self.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("short script")
	if counter == 1:
		if cur_pos - self.position.y < 70: 
			self.position.y -= 10

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		counter += 1
		if counter == 2:
			body.score += 100
			self.queue_free()
