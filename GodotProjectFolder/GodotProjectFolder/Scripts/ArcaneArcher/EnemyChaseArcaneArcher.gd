extends State
class_name EnemyChaseArcaneArcher

@export var enemy: CharacterBody2D
@export var speed := .5
@export var chase_drop_distance := 100
@export var attempt_attack_range := 50
@export var rayCast: RayCast2D

var player: CharacterBody2D

func Enter():
	#print("Follow")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta:float):
	var direction = player.global_position - enemy.global_position 
	var angle_to_player = direction.angle()
	rayCast.global_rotation = angle_to_player
	
	if direction.length() > attempt_attack_range:
		enemy.velocity = direction * speed
	if direction.length() < attempt_attack_range:
		direction = enemy.global_position - player.global_position
		enemy.velocity = direction * speed
	else:	
		if player.global_position.x < enemy.global_position.x:
			enemy.flip()
		if rayCast.is_colliding() and rayCast.get_collider() == player:
			ChangeState.emit(self, "EnemyAttack")

	if direction.length() > chase_drop_distance:
		ChangeState.emit(self, "EnemyIdle")

