extends Node2D

@onready var player: CharacterBody2D
var damage:int = 2

# creating bomb is now handled in the CharacterScript
#func create_bomb():
	#player = get_tree().get_first_node_in_group("Player")
	#if Input.is_action_just_pressed("bomb"):
		#print(self.position)
		#self.position = player.position
		#$AnimationPlayer.play("explosion")

func explode():
	# Known bug is player is getting damaged as soon as its placed?
	self.position = player.position + Vector2(0,-15)
	
	$AnimationPlayer.play("explosion")
