extends CharacterBody2D

@export var speed: float = 70.0  # Velocidad del enemigo

var player: Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player")

func _process(delta):
	if player:
		if is_touching_player():
			player.handle_death()

func is_touching_player() -> bool:
	if collision_shape.shape == null:
		print("Error: CollisionShape2D no tiene una forma asignada.")
		return false


	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = collision_shape.shape
	query.transform = global_transform  
	query.collide_with_bodies = true

	var space_state = get_world_2d().direct_space_state
	var results = space_state.intersect_shape(query)

	for result in results:
		if result.collider.is_in_group("player"):  
			return true
	return false
