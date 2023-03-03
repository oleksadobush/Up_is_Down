extends Camera2D

# 768 black px
# bteween levels 384 white px
# one lewel is 1152 px in height

var DIFFERENCE = 576
var SHIFT = 1152
var X_OFFSET = 384
var Y_OFFSET = 384

var LEVEL1_Y = 384
var LEVEL2_Y = 384 + 1152
var LEVEL3_Y = 384 + 1152*2

var next_position: Vector2 = Vector2()

onready var player = get_parent().get_node("Player")

func _ready():
	next_position.x = player.get_position().x + X_OFFSET
	next_position.y = Y_OFFSET
	set_position(next_position)


func _physics_process(_delta):
	if is_instance_valid(player):
		next_position.x = player.get_position().x + X_OFFSET
		if player.get_position().y >= get_position().y + DIFFERENCE:
			next_position.y += SHIFT
		elif player.get_position().y <= get_position().y - DIFFERENCE:
			next_position.y -= SHIFT
		set_position(next_position)
