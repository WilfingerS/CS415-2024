extends State

@export var enemy: CharacterBody2D
@export var speed := 1.75
@export var duration := 1

var player: CharacterBody2D
var direction

func Enter():
	print("SlideInto")
	player = get_tree().get_first_node_in_group("Player")
	direction =  enemy.global_position - player.global_position
	await get_tree().create_timer(duration).timeout
	ChangeState.emit(self, "Engage")
	
func Physics_Update(delta:float):
	enemy.velocity = direction * speed	
	
