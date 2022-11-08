extends KinematicBody2D

var SPEED: int = 600
var SPEED_UP: int = 600
var JUMP_FORCE: int = 775
var SPRING_FORCE: int = 6000
var NEAR_WALL_SPEED: int = 10
var LERP_WEIGHT: float = 0.3

var gravity: int = 2000

var _jumped: bool = false
var _sliding: bool = false
var _velocity: Vector2 = Vector2()

onready var EdgeRayJump = get_node("EdgeRayJump")
onready var WallRay = get_node("WallRay")
onready var CeillingRay = get_node("CeillingRay")
onready var AnimPlayer = get_node("AnimationPlayer")


func _physics_process(delta):
	_velocity.x = SPEED
	if not _jumped and Input.is_action_just_pressed("UP"):
		_velocity.y -= JUMP_FORCE
		if not WallRay.is_colliding():
			if EdgeRayJump.is_colliding():
				_velocity.y -= NEAR_WALL_SPEED
		_jumped = true

	if not _jumped and Input.is_action_pressed("RIGHT"):
		_velocity.x += SPEED_UP

	if not _sliding and Input.is_action_pressed("DOWN"):
		AnimPlayer.play("start_slide")
		_sliding = true
	if _sliding and not CeillingRay.is_colliding() and \
	(not EdgeRayJump.is_colliding() or WallRay.is_colliding()):
		AnimPlayer.play("finish_slide")
		_sliding = false

	if is_on_floor():
		_jumped = false
	else:
		_jumped = true

	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, Vector2.UP).y


func spring_jump():
	_velocity.y -= lerp(_velocity.y, _velocity.y + SPRING_FORCE, LERP_WEIGHT)
