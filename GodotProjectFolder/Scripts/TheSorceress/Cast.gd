extends State

@export var enemy: CharacterBody2D
@export var speed := .5
@export var cast_range := 150
@export var rayCast: RayCast2D

var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize()
	print("CAST MODE")

func Physics_Update(delta:float):
	var direction = player.global_position - enemy.global_position 
	var angle_to_player = direction.angle()
	rayCast.global_rotation = angle_to_player
	
	if direction.length() > cast_range:
		enemy.velocity = direction * speed
	else:	
		if player.global_position.x < enemy.global_position.x:
			enemy.flip()
		
		var action = randi_range(1,4)
		if rayCast.is_colliding() and rayCast.get_collider() == player and action > 1:
			var random = randi_range(1,3)
			match random:
				1:
					ChangeState.emit(self, "Summon")
				2:
					ChangeState.emit(self, "Magic Missle")
				3:
					ChangeState.emit(self, "Force Current")
