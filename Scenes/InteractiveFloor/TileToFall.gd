extends Area2D

var falling_speed = 10000

func _ready():
	$Sprite/AnimationPlayer.current_animation = "default"

func _on_MovingTile_body_entered(body):
	$Sprite/AnimationPlayer.current_animation = "falling"
	body.gravity += falling_speed


func _on_MovingTile_body_exited(body):
	body.gravity -= falling_speed
