extends StaticBody2D


func _on_Area2D_body_entered(body):
	if body.has_method("spring_jump"):
		body.spring_jump()
