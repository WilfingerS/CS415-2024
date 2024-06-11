extends CharacterBody2D

var speed = 125
var chase = false
var player = null
		
func _on_detection_area_body_entered(body):
	player = body
	chase = true

func _on_detection_area_body_exited(body):
	player = null
	chase = false

func _physics_process(delta):
	move_and_slide()
	if chase:
		position += (player.position - position)/speed
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")	
