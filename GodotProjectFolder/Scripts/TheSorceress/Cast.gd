extends State

@export var enemy: CharacterBody2D
@export var speed := .5
@export var cast_range := 100
@export var rayCast: RayCast2D
@export var spell_cast_delay := 5  # Delay in seconds before the enemy can cast another spell

var player: CharacterBody2D
var can_cast_spell := true

func _ready():
	randomize()
	
	# Configure the spell cast timer
	$spell_cast_cooldown.wait_time = spell_cast_delay
	$spell_cast_cooldown.one_shot = true

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print("CAST MODE")

func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	var angle_to_player = direction.angle()
	rayCast.global_rotation = angle_to_player
	
	if direction.length() > cast_range:
		enemy.velocity = direction.normalized() * speed
	else:
		
		if can_cast_spell and rayCast.is_colliding() and rayCast.get_collider() == player:
			var random = randi_range(1, 5)
			match random:
				1:
					ChangeState.emit(self, "Summon")
				2:
					ChangeState.emit(self, "Magic Missile")
				3:
					ChangeState.emit(self, "Force Current")
				4:
					ChangeState.emit(self, "Curse")
				5:
					ChangeState.emit(self, "Beam")
			# Start the timer and set can_cast_spell to false
			can_cast_spell = false
			$spell_cast_cooldown.start()

func _on_spell_cast_cooldown_timeout():
	can_cast_spell = true
