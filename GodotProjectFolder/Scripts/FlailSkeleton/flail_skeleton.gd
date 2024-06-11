extends CharacterBody2D

var attacking = false

func _physics_process(_delta):
	move_and_slide()
	
	if attacking:
		return
		
	if velocity.length() > 0:
		$AnimationPlayer.play("Walk")
	else:
		$AnimationPlayer.play("Idle")
		
	if velocity.x > 0:
		$Sprite2D.set_scale(Vector2(1,1))
	else:
		$Sprite2D.set_scale(Vector2(-1,1))

func attack():
	attacking = true
	$AnimationPlayer.play("Attack")
	var attack_duration = $AnimationPlayer.current_animation_length
	await get_tree().create_timer(attack_duration).timeout
	attacking = false
