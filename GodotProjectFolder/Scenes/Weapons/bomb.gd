extends Node2D

var player: CharacterBody2D
var damage:int = 5

func create_bomb():
	player = get_tree().get_first_node_in_group("Player")
	if Input.is_action_just_pressed("bomb"):
		print(self.position)
		self.position = player.position
		$AnimationPlayer.play("explosion")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	create_bomb()
