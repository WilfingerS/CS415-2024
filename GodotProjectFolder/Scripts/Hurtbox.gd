extends Area2D
class_name Hurtbox

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", self._on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var hitbox = area as Hitbox
	var isPlayer:bool = (self.get_parent().name == "Player_Character") # scuffed way imo but it works
	if hitbox == null or hitbox.owner == self.get_parent() or self.get_parent().is_ancestor_of(hitbox): #No hitbox detected
		return
	# Above is used to check if hitbox is hitting itself
	if isPlayer:
		# Do ur stuff here maybe?
		pass

	print(hitbox.owner.name + " hit: " + self.get_parent().name)
	self.owner.take_damage(hitbox.owner.damage)
