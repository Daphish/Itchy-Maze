extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_button_pressed() -> void:
	print("Intentando cambiar de escena...")
	print(get_tree())  # Esto debería mostrar: [SceneTree]
	_on_start_button_pressed()
