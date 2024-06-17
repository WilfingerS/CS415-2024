
extends Area2D
class_name Hurtbox

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", self._on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if _is_valid_hit(area):
		var hitbox = area as Hitbox
		print(hitbox.owner.name + " hit: " + self.get_parent().name)
		self.owner.take_damage(hitbox.owner.damage)

func _is_valid_hit(area: Area2D) -> bool:
	if area is Hitbox:
		var hitbox = area as Hitbox
		var hitboxGroup = hitbox.get_owner().get_groups()
		var hurtboxGroup = self.get_owner().get_groups()
		return hitboxGroup != hurtboxGroup and hitbox.owner != self.get_parent() and not self.get_parent().is_ancestor_of(hitbox)
	return false
