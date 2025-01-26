extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D 
@onready var tiempo = $Timer

@export var game_over_scene:PackedScene
@export var win_scene:PackedScene
@export var respawn_position:Vector2 = Vector2(100, 100)  # Posición inicial del personaje

@export var move_speed:float 
@export var jump_speed:float
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var spikes = $/root/level2/TileMapLayer/spikes
var is_dead = false  # Manejo del estado del personaje

func _physics_process(delta):
	if is_dead:
		return  # Si está muerto, no realizar lógica de movimiento
	jump(delta)
	move_x()
	update_animations()
	move_and_slide()
	
	# Detectar colisión con los picos
	if is_on_spike():
		handle_death()

func update_animations():
	if is_dead:
		animated_sprite.play("dead")
	else:
		# Reproduce "idle" solo si el jugador no se mueve
		if velocity.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("idle")  # Cambia "default" si tienes otro nombre para el estado de caminar

func jump(delta):
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		
	velocity.y += gravity * delta
	

func move_x():
	var input_axis = Input.get_axis("move_left", "move_right")
	velocity.x = input_axis * move_speed
	
func is_on_spike() -> bool:
	# Detectar si el jugador está tocando un Tile en el nodo "spikes"
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() == spikes:  # Compara si el objeto colisionado es el nodo "spikes"
			return true
	return false

func handle_death():
	if is_dead:
		return  # Evita múltiples llamadas a esta función si ya está muerto
	
	is_dead = true
	animated_sprite.play("dead")
	
	# Usa un temporizador para retrasar el reinicio de la escena
	tiempo.start()
	tiempo.timeout.connect(_on_death_timeout)

func _on_death_timeout():
	# Reiniciar la escena después de la animación de muerte
	#get_tree().reload_current_scene()
	# Cambiar a la escena de "Game Over"
	if game_over_scene:
		get_tree().change_scene_to_packed(game_over_scene)
	else:
		print("No se ha asignado la escena de Game Over")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	if win_scene:
		call_deferred("change_to_win_scene")
	else:
		print("No se ha asignado la escena de win")

func change_to_win_scene():
	get_tree().change_scene_to_packed(win_scene)
