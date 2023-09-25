extends Node2D

var tilemap : TileMap
var light_area : Area2D

func _ready():
	# Get references to the TileMap and Area2D nodes
	tilemap = $Background/TileMap
	light_area = $CharacterBody2D/LightArea
	
	# Connect signals for collision detection
	light_area.connect("body_entered", self, "_on_area_enter")
	light_area.connect("body_exited", self, "_on_area_exit")

func _on_area_enter(body):
	if body is TileMap:
		# The area entered the TileMap node (collision detected)
		# Loop through the tiles in the collision area
		for cell in area2d.get_overlapping_areas():
			if cell is tilemap:
				# Get the tile coordinates for the collision
				var tile_position = tilemap.world_to_map(body.position)
				
				# Set the visibility of the tile at the collision position
				tilemap.set_cellv(tile_position, 0)  # Change '0' to your tile index if needed

func _on_area_exit(body):
	if body is TileMap:
		# The area exited the TileMap node (collision ended)
		# Loop through the tiles in the collision area
		for cell in area2d.get_overlapping_areas():
			if cell is tilemap:
				# Get the tile coordinates for the collision
				var tile_position = tilemap.world_to_map(body.position)
				
				# Set the tile back to invisible (or a different index if needed)
				tilemap.set_cellv(tile_position, -1)  # Set to -1 to make it invisible

