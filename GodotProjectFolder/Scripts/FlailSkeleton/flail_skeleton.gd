extends CharacterBody2D

@export var HP:int = 3
@export var damage:int = 1

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
	
func take_damage(dmg:int):
	set_hp(HP-dmg)
	
func set_hp(newHP):
	if newHP <= 0:
		HP = 0
		kill()
	else:
		HP = newHP

func kill():
	print("Dead?")
	queue_free() # apparently this will delete node after it can be
