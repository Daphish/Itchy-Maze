extends Control

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.play()
	audio_player.finished.connect(_on_audio_finished)

func _on_audio_finished():
	audio_player.play()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_volver_pressed() -> void:
	_on_start_button_pressed()
