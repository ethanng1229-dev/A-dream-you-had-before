extends CharacterBody2D

var speed: float = 200
var jump_velocity: float = -400
var gravity: float = 900

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var area: Area2D = $Hitbox  # optional for precise spike detection

func _physics_process(delta: float) -> void:
	var velocity: Vector2 = self.velocity

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed

	if direction != 0:
		sprite.play("walking")
		sprite.flip_h = direction < 0
	else:
		if is_on_floor():
			sprite.play("idle")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	self.velocity = velocity
	move_and_slide()

func die():
	print("Player died!")
	position = Vector2(100, 100)  # respawn point
