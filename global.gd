extends Node

var score = 0
var pause = false


# Player data
var position_x = 402
var position_y = 967.7565
var health = 5

var time = 100

# coins
var coins_x = [0,0,0,0,0,0,0,0]
var coins_y = [0,0,0,0,0,0,0,0]
var coins_counter = [0,0,0,0,0,0,0,0]

#enemies
var enemies_x = [0,0,0,0,0,0,0,0,0,0]
var enemies_y = [0,0,0,0,0,0,0,0,0,0]

#fire
var fire_x = [0,0,0,0]
var fire_y = [0,0,0,0]
var fire_counter = [0,0,0,0]

func reset():
	score = 0
	pause = false


	# Player data
	position_x = 402
	position_y = 967.7565
	health = 5

	time = 100

	# coins
	var coins_x = [0,0,0,0,0,0,0,0]
	var coins_y = [0,0,0,0,0,0,0,0]
	var coins_counter = [0,0,0,0,0,0,0,0]

	#enemies
	var enemies_x = [0,0,0,0,0,0,0,0,0,0]
	var enemies_y = [0,0,0,0,0,0,0,0,0,0]

	#fire
	var fire_x = [0,0,0,0]
	var fire_y = [0,0,0,0]
	var fire_counter = [0,0,0,0]
