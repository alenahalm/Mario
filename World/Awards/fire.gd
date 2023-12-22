extends AnimatableBody2D

var counter = 0
var cur_pos
var index = 0

func _ready():
	cur_pos = self.position.y
	if self.name.substr(4) == "":
		index = 0
	else:
		index = int(self.name.substr(4))
	if Global.fire_x[index] + Global.fire_y[index] != 0:
		self.global_position.x = Global.fire_x[index]
		self.global_position.y = Global.fire_y[index]
		self.counter = Global.fire_counter[index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.pause:
		return
	
	Global.fire_x[index] = self.global_position.x
	Global.fire_y[index] = self.global_position.y
	Global.fire_counter[index] = counter
	
	if counter == 1:
		if cur_pos - self.position.y < 80: 
			self.position.y -= 10

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		counter += 1
		if counter == 2:
			body.score += 1000
			body.health = 10
			Global.fire_x[index] = -500
			Global.fire_y[index] = -500
			self.queue_free()
