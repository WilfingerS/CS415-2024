extends State
class_name EnemyAttackArcaneArcher

@export var enemy: CharacterBody2D
@export var projectile: PackedScene = null
@export var rayCast: RayCast2D

func Enter():
	#print("Attack")
	enemy.velocity = Vector2.ZERO
	await enemy.attack()
	
	if projectile:
		var arrow = projectile.instantiate()
		#get_tree().current_scene.add_child(arrow)
		enemy.add_child(arrow)
		arrow.shooter = enemy
		#arrow = arrow.get_node("arcane_arrow")
		
		arrow.global_position = enemy.global_position
		arrow.global_rotation = rayCast.global_rotation
		
	ChangeState.emit(self, "EnemyChase")

