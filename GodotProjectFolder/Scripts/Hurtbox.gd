extends Area2D
class_name Hurtbox

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", self._on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	var hitbox = area as Hitbox

	#print(hitbox.owner.name) #the hitbox that hit them
	#print(self.owner.name) #Hurtbox that should be damaged?
	if hitbox == null or hitbox.owner == self.get_parent() or self.get_parent().is_ancestor_of(hitbox): #No hitbox detected
		#print("No hitbox or Hit itself lol?")
		return
	
	print(hitbox.owner.name + " hit: " + self.get_parent().name)
	self.owner.take_damage(hitbox.owner.damage)
	
