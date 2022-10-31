extends Area2D

func _ready():
	$Sprite/AnimationPlayer.current_animation = "default"

func _on_MovingTile_body_entered(body):
	$Sprite/AnimationPlayer.current_animation = "falling"
	body.velocity.y += 400
