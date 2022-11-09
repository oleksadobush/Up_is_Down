extends Camera2D

onready var player = get_node("../Player")
onready var next_position: Vector2 = Vector2()
onready var starting_position: Vector2 = Vector2()

func _ready():
	starting_position.x = player.get_position().x + 300
	starting_position.y = player.get_position().y - 250
	self.set_position(starting_position)


func _physics_process(delta):
	next_position.x = player.get_position().x + 300
	next_position.y = self.get_position().y
	self.set_position(next_position)
