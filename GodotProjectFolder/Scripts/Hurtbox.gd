extends Area2D
class_name Hurtbox

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox:Hitbox) -> void:
	#print(hitbox.owner.name) #the hitbox that hit them
	#print(self.get_parent().name) #Hurtbox that should be damaged?
	if hitbox == null or hitbox.owner == self.get_parent(): #No hitbox detected
		print("No hitbox or Hit itself lol?")
		return
		
	print(hitbox.owner.name + " hit: " + self.get_parent().name)
	#self.get_wparent().take_damage(hitbox.owner.damage)
	
