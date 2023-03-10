extends Camera2D

var DIFFERENCE = 512 # 512
var SHIFT = 768 # 1280
var X_OFFSET = 300
var Y_OFFSET = 250

var next_position: Vector2 = Vector2()

@onready var player = get_parent().get_node("Player")

func _ready():
	next_position.x = player.get_position().x + X_OFFSET
	next_position.y = player.get_position().y - Y_OFFSET
	set_position(next_position)


func _physics_process(_delta):
	if is_instance_valid(player):
		next_position.x = player.get_position().x + X_OFFSET
		if player.get_position().y >= get_position().y + DIFFERENCE:
			next_position.y += SHIFT
		elif player.get_position().y <= get_position().y - DIFFERENCE:
			next_position.y -= SHIFT
		set_position(next_position)
