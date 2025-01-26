extends Control

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.play()
	audio_player.finished.connect(_on_audio_finished)

func _on_audio_finished():
	audio_player.play()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_button_pressed() -> void:
	print("Intentando cambiar de escena...")
	print(get_tree())  # Esto debería mostrar: [SceneTree]
	_on_start_button_pressed()


func _on_help_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/help.tscn")
