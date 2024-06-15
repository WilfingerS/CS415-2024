extends Node2D
class_name Projectile

@export var speed := 10
@export var damage:int = 1
#@onready var arrow = get_node("arcane_arrow")
var shooter: CharacterBody2D = null

func _physics_process(_delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction 
	#print(direction)

func destory():
	queue_free()

func _on_area_entered(area):
	destory()
	
func _on_body_entered(body):
	print(body)
	if body == shooter:
		return
	destory()

func _on_visible_on_screen_notifier_2d_screen_exited():
	destory()

func _ready():
	pass
	# Set the collision layer and mask for the arrow
	# Assume 1 is the player's layer and 2 is the enemy's layer
	#collision_layer = 1
	#collision_mask = 2
