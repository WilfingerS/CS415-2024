extends State
class_name EnemyChase

@export var enemy: CharacterBody2D
@export var speed := .25
@export var ChaseDropDistance := 500
@export var AttemptAttackRange := 100

var player: CharacterBody2D

func Enter():
	print("Follow")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta:float):
	var direction = player.global_position - enemy.global_position 
	
	if direction.length() > AttemptAttackRange:
		enemy.velocity = direction * speed
	else:
		ChangeState.emit(self, "EnemyAttack")

	if direction.length() > ChaseDropDistance:
		ChangeState.emit(self, "EnemyIdle")
