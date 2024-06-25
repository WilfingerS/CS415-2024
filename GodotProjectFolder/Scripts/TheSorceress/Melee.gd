extends State

@export var enemy: CharacterBody2D
@export var speed := .5
@export var attempt_attack_range := 75

var player: CharacterBody2D

func Enter():
	print("Melee")
	player = get_tree().get_first_node_in_group("Player")
	
func Physics_Update(delta:float):
	var direction = player.global_position - enemy.global_position 
	#print(direction)
	if direction.length() > attempt_attack_range:
		enemy.velocity = direction * speed
	else:	
		if player.global_position.y > enemy.global_position.y || enemy.global_position.y  < player.global_position.y:
			enemy.velocity = (enemy.global_position - player.global_position).rotated(90) * (speed)
		else: 
			ChangeState.emit(self, "Engage")

