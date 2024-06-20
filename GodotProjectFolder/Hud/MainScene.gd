extends Node2D

@onready var health_bar = $CanvasLayer/HeartBar
@onready var player = $Character

func _ready():
	health_bar.setMaxHealth(player.maxHP)
	health_bar.update(player.HP)
	player.hp_changed.connect(health_bar.update)
