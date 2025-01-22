extends CharacterBody2D

@export var move_speed:float 
@export var jump_speed:float
var gravity=ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		velocity.y=-jump_speed
		
	velocity.y+=gravity*delta
	
	move_x()
	move_and_slide()

func move_x():
	var input_axis=Input.get_axis("move_left","move_right")
	velocity.x=input_axis*move_speed