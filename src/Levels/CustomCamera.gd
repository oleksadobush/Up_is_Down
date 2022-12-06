extends Camera2D

var DIFFERENCE = 512 # 512
var SHIFT = 768 # 1280

onready var player = get_node("../Player")
onready var next_position: Vector2 = Vector2()
onready var starting_position: Vector2 = Vector2()

func _ready():
	next_position.x = player.get_position().x + 300
	next_position.y = player.get_position().y - 250
	self.set_position(next_position)


func _physics_process(delta):
	if is_instance_valid(player):
		next_position.x = player.get_position().x + 300
		if player.get_position().y >= self.get_position().y + DIFFERENCE:
			next_position.y += SHIFT
		elif player.get_position().y <= self.get_position().y - DIFFERENCE:
			next_position.y -= SHIFT
		self.set_position(next_position)
