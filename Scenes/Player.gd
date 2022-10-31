extends KinematicBody2D

export var speed = 600
export var jumpforce = 800
export var springforce = 6000
export var gravity = 2000
export var speed_up = 600

onready var ray_fall = get_node("EdgeRayFall")
onready var ray_jump = get_node("EdgeRayJump")
onready var ray_wall = get_node("WallRay")

var jumped = false
var sliding = false
var velocity = Vector2()

func _physics_process(delta):
	velocity.x = speed
	if Input.is_action_just_pressed("UP"):
		if not jumped:
			velocity.y -= jumpforce
			if not ray_wall.is_colliding():
				if ray_fall.is_colliding():
					velocity.y += 200
				elif ray_jump.is_colliding():
					velocity.y -= 200
			jumped = true

	if Input.is_action_pressed("RIGHT"):
		if not jumped:
			velocity.x += speed_up

	if Input.is_action_pressed("DOWN"):
		pass
	
	velocity.y += gravity*delta
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	
	if is_on_floor():
		jumped = false
	else:
		jumped = true
	
func spring_jump():
	velocity.y -= lerp(velocity.y, velocity.y + springforce, 0.3)
