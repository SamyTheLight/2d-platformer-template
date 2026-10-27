extends CharacterBody2D

# Player movement variables
@export var move_speed: float = 200.0
@export var sprint_multiplier: float = 1.8

# Player jump variables
@export var jump_height: float = 100.0
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descent: float = 0.4

# Player state variables
@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var is_sprinting: bool = false

func _physics_process(delta: float) -> void:
	velocity.y += get_jump_gravity() * delta
	velocity.x = get_input_velocity() * get_current_speed()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	move_and_slide()

func get_jump_gravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	else:
		return fall_gravity

func get_input_velocity() -> float:
	return Input.get_axis("move_left", "move_right")

func get_current_speed() -> float:
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")
	return move_speed * sprint_multiplier if is_sprinting else move_speed

func jump() -> void:
	velocity.y = jump_velocity
