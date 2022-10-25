extends KinematicBody2D

export var speed = 600
export var jumpforce = 800
export var gravity = 2000
export var speed_up = 700

var jumped = false
var velocity = Vector2()
onready var animation_player = get_node("AnimationPlayer")

func _physics_process(delta):
	velocity.x = speed
	if Input.is_action_just_pressed("UP"):
		if not jumped:
			velocity.y -= jumpforce
			jumped = true
	if Input.is_action_pressed("RIGHT"):
		velocity.x += speed_up
	if Input.is_action_just_pressed("DOWN"):
		animation_player.play("start_slide")
	if Input.is_action_just_released("DOWN"):
		animation_player.play("finish_slide")
	
	velocity.y += gravity*delta
	velocity.y = move_and_slide(velocity, Vector2.UP).y
	
	if is_on_floor():
		jumped = false
	else:
		jumped = true
	
