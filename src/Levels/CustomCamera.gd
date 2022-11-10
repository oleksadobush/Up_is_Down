extends Camera2D

var DIFFERENCE = 512 # 512
var SHIFT = 768 # 1280

var next_position: Vector2 = Vector2()

onready var player = get_parent().get_node("Player")

func _ready():
	next_position.x = player.get_position().x + 300
	next_position.y = player.get_position().y - 250
	set_position(next_position)


func _physics_process(delta):
	next_position.x = player.get_position().x + 300
	if player.get_position().y >= get_position().y + DIFFERENCE:
		next_position.y += SHIFT
	elif player.get_position().y <= get_position().y - DIFFERENCE:
		next_position.y -= SHIFT
	set_position(next_position)
