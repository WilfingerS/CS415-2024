extends CharacterBody2D

@export var HP:int = 100
@export var transition_hp:int = 40
@export var damage:int = 1

var attacking = false
var is_dead = false
var is_hit = false
var phase2 = false

func _physics_process(_delta):
	if is_dead || is_hit || attacking:
		return
		
	move_and_slide()
		
	if velocity.length() > 0:
		$AnimationPlayer.play("Idle")
	else:
		#$AnimationPlayer.play("Idle")
		pass

func cast():
	if attacking || is_dead:
		return
	
	attacking = true
	$AnimationPlayer.play("Cast")
	var attack_duration = $AnimationPlayer.current_animation_length +.01
	await get_tree().create_timer(attack_duration).timeout
	attacking = false
	
func take_damage(dmg:int):
	if is_dead or is_hit:
		return
		
	is_hit = true
	$OnHitPlayer.play("OnHit")
	set_hp(HP - dmg)
	is_hit = false

func set_hp(newHP):
	if newHP <= 0:
		HP = 0
		kill()
	else:
		HP = newHP

func kill():
	if is_dead:
		return
	
	print("Dead?")
	is_dead = true
	#$AnimationPlayer.play("Death")
	#var death_duration = $AnimationPlayer.current_animation_length
	#await get_tree().create_timer(death_duration).timeout
	queue_free() # This will delete the node after the animation completes
