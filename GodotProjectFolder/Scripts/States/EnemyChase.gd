extends State
class_name EnemyChase

@export var enemy: CharacterBody2D
@export var speed := .25
@export var chase_drop_distance := 500
@export var attempt_attack_range := 100

var player: CharacterBody2D

func Enter():
	print("Follow")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta:float):
	var direction = player.global_position - enemy.global_position 
	
	if direction.length() > attempt_attack_range:
		enemy.velocity = direction * speed
	else:
		ChangeState.emit(self, "EnemyAttack")

	if direction.length() > chase_drop_distance:
		ChangeState.emit(self, "EnemyIdle")
