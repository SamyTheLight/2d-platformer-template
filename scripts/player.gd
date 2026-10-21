extends CharacterBody2D

@export var move_speed: float = 200.0
@export var sprint_multiplier: float = 1.8

@export var jump_height: float = 100.0
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descent: float = 0.4

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_sprinting := false

func _physics_process(delta: float) -> void:
	velocity.y += get_jump_gravity() * delta
	velocity.x = get_input_velocity() * get_current_speed()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	
	move_and_slide()
	update_animation()

func update_animation() -> void:
	var direction := get_input_velocity()
	if direction != 0.0:
		animated_sprite.flip_h = direction < 0.0

	if not is_on_floor():
		animated_sprite.play("jump" if velocity.y < 0.0 else "fall")
	elif direction != 0.0:
		animated_sprite.play("run" if is_sprinting else "walk")
	else:
		animated_sprite.play("idle")

func get_jump_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func get_current_speed() -> float:
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint")
	return move_speed * sprint_multiplier if is_sprinting else move_speed

func jump() -> void:
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	return Input.get_axis("left", "right")
