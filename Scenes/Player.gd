extends KinematicBody2D

var jumped: bool = false
var sliding: bool = false
var velocity: Vector2 = Vector2()
var lerp_weight: float = 0.3

export var speed: int = 600
export var speed_up: int = 600
export var jumpforce: int = 800
export var springforce: int = 6000
export var gravity: int = 2000

onready var EdgeRayFall = get_node("EdgeRayFall")
onready var EdgeRayJump = get_node("EdgeRayJump")
onready var WallRay = get_node("WallRay")
onready var CeillingRay = get_node("CeillingRay")
onready var AnimPlayer = get_node("AnimationPlayer")


func _physics_process(delta):
	velocity.x = speed
	if not jumped and Input.is_action_just_pressed("UP"):
		velocity.y -= jumpforce
		if not WallRay.is_colliding():
			if EdgeRayFall.is_colliding():
				velocity.y += 200
			elif EdgeRayJump.is_colliding():
				velocity.y -= 200
		jumped = true

	if Input.is_action_pressed("RIGHT"):
		if not jumped:
			velocity.x += speed_up

	if not sliding and Input.is_action_pressed("DOWN"):
		AnimPlayer.play("start_slide")
		sliding = true
	if sliding and not CeillingRay.is_colliding() and not EdgeRayFall.is_colliding():
		AnimPlayer.play("finish_slide")
		sliding = false

	if is_on_floor():
		jumped = false
	else:
		jumped = true

	velocity.y += gravity * delta
	velocity.y = move_and_slide(velocity, Vector2.UP).y


func spring_jump():
	velocity.y -= lerp(velocity.y, velocity.y + springforce, lerp_weight)
