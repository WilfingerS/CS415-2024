extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D

func Enter():
	print("Attack")
	
func Physics_Update(delta:float):
	enemy.velocity = Vector2() * 0
	await enemy.attack()
	ChangeState.emit(self, "EnemyChase")
	
