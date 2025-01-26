extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_win_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	

func _on_menu_pressed() -> void:
	_on_win_button_pressed()
