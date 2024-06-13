extends Hitbox

@export var speed := 10
var shooter : Node = null

func _physics_process(_delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += speed * direction 

func destory():
	queue_free()

func _on_area_entered(area):
	destory()
	
func _on_body_entered(body):
	if body == shooter:
		return
	destory()

func _on_visible_on_screen_notifier_2d_screen_exited():
	destory()

func _ready():
	# Set the collision layer and mask for the arrow
	# Assume 1 is the player's layer and 2 is the enemy's layer
	collision_layer = 1
	collision_mask = 2
