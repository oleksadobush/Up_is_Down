extends KinematicBody2D

const ENEMY_SPEED: int = 600
const JUMP_FORCE: int = 800
const LERP_WEIGHT: float = 0.3
const SPRING_FORCE: int = 6000

var gravity: int = 2000

onready var Player = get_node("../Player")

onready var EdgeRayJump = get_node("EdgeRayJump")
onready var WallRay = get_node("WallRay")
onready var CeillingRay = get_node("CeillingRay")
onready var UnderRay = get_node("UnderRay")
onready var AnimPlayer = get_node("AnimationPlayer")

var sliding: bool = false
var jumped: bool = false
var velocity: Vector2 = Vector2()

func _physics_process(delta):
	if is_instance_valid(Player):
		velocity.x = (Player.position - position).normalized().x * ENEMY_SPEED
		
		if velocity.y == 0:
			jumped = false
		
		if WallRay.is_colliding() and not sliding and not UnderRay.is_colliding():
			AnimPlayer.play("start_slide")
			sliding = true
		if sliding and not CeillingRay.is_colliding() and not EdgeRayJump.is_colliding():
			AnimPlayer.play("finish_slide")
			sliding = false
		if not sliding and not jumped and UnderRay.is_colliding() and WallRay.is_colliding():
			velocity.y -= JUMP_FORCE
			jumped = true
			
		velocity = move_and_slide(velocity + Vector2.DOWN * gravity * delta)
		
	elif sliding and not CeillingRay.is_colliding():
		AnimPlayer.play("finish_slide")
		sliding = false
		

func spring_jump():
	velocity.y -= lerp(velocity.y, velocity.y + SPRING_FORCE, LERP_WEIGHT)


func _on_Area2D_body_entered(body):
	body.queue_free()


