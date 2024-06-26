extends State

@export var enemy: CharacterBody2D
@export var speed := 5
@export var attempt_attack_range := 50

var player: CharacterBody2D

func Enter():
	print("SlideInto")
	player = get_tree().get_first_node_in_group("Player")
	
func Physics_Update(delta:float):
	var direction = player.global_position - enemy.global_position 
	enemy.velocity = direction * speed	
	
	if player.global_position.x < enemy.global_position.x:
		enemy.flip()
		
	if direction.length() < attempt_attack_range:
		ChangeState.emit(self, "Engage")

