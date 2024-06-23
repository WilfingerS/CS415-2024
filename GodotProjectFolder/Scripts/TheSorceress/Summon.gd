extends State

@export var enemy : CharacterBody2D
@export var summoned_creature1: PackedScene = null
@export var summon_effect: PackedScene = null

@onready var tilemap_parent = get_tree().current_scene

func Enter():
	print("Summon")
	enemy.velocity = Vector2.ZERO
	await enemy.cast()
	summon_enemies(3)
	ChangeState.emit(self, "Cast")
	
func detect_tilemap() -> TileMap:
	var summoner_pos = enemy.global_position
	var min_distance = 1e9
	var closest_tilemap = null

	for child in tilemap_parent.get_children():
		if child.get_child_count() != 0:
			var valid_child = child.get_child(0)
			
			if valid_child is TileMap:
				var tilemap = valid_child
				var tile_size = tilemap.tile_set.tile_size  # Access the tile size from the TileSet
				var used_rect = tilemap.get_used_rect()
				
				print(child)
				print(tilemap)
				
				for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
					for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
						var cell_pos = Vector2i(x, y)
						var cell_local_pos = tilemap.local_to_map(cell_pos)
						var cell_world_pos = tilemap.to_global(cell_local_pos)

						var distance = summoner_pos.distance_to(cell_world_pos)
				
						if distance < min_distance:
							min_distance = distance
							closest_tilemap = tilemap
	return closest_tilemap
	

func find_empty_cells(tilemap: TileMap) -> Array:
	var empty_cells = []
	var wall_cells = tilemap.get_used_cells(1)  # Get cells occupied by walls in layer 1
	var all_cells = tilemap.get_used_cells(0)  # Get all cells in layer 0

	# Create a set of excluded cells
	var excluded_cells = {}
	for wall_cell in wall_cells:
		excluded_cells[wall_cell] = true
		# Add adjacent cells to the exclusion list
		var adjacent_offsets = [Vector2i(-1, 0), Vector2i(1, 0), Vector2i(0, -1), Vector2i(0, 1)]
		for offset in adjacent_offsets:
			var adjacent_cell = wall_cell + offset
			excluded_cells[adjacent_cell] = true

	# Check all cells in layer 0
	for cell in all_cells:
		if not excluded_cells.has(cell):
			empty_cells.append(cell)

	return empty_cells

func summon_enemies(amount: int):
	var tilemap = detect_tilemap()
	if tilemap:
		var empty_cells = find_empty_cells(tilemap)
		var num_empty_cells = empty_cells.size()
		var num_to_summon = min(amount, num_empty_cells)
		var chosen_cells = []

		# Randomly select cells without replacement
		while chosen_cells.size() < num_to_summon:
			var random_index = randi() % num_empty_cells
			var random_cell = empty_cells[random_index]
			if random_cell not in chosen_cells:
				chosen_cells.append(random_cell)

		for cell_pos in chosen_cells:
			var cell_local_pos = tilemap.map_to_local(cell_pos)
			var cell_world_pos = tilemap.to_global(cell_local_pos)
			summon_enemy_at_position(cell_world_pos)
			
func summon_enemy_at_position(position: Vector2):
	
	if summon_effect:
		var effect = summon_effect.instantiate()
		get_tree().current_scene.add_child(effect)
		effect.global_position = position
		#effect.play()
	
	if summoned_creature1:
		var skeleton = summoned_creature1.instantiate()
		get_tree().current_scene.add_child(skeleton)
		skeleton.global_position = position
			
		print("Enemy summoned at position: ", position)
	else:
		print("Failed to instantiate enemy")
