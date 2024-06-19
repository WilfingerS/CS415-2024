extends Node2D

var player: CharacterBody2D	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interaction_area_body_entered(body):
	player = get_tree().get_first_node_in_group("Player")
	if body == player:
		player.addCoin()
		queue_free()
	
