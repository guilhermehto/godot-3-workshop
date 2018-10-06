extends KinematicBody2D

export var SPEED = 250
export var MAX_HEALTH = 100
export var GRAVITY = 500

var direction = 0
var motion = Vector2()
var health = MAX_HEALTH

signal died

func _ready():
	randomize()
	direction = 1 if rand_range(0, 100) > 50 else -1
	_update_sprite_direction()
	motion.y = GRAVITY

func _physics_process(delta):
	motion.x = SPEED * direction
	move_and_slide(motion, Vector2(0, -1))

func damage(value):
	health -= value
	print(health)
	if health <= 0:
		emit_signal('died')
		queue_free()

func _on_DirectionCheck_body_entered(body):
	if is_on_floor() and body is TileMap:
		direction = -direction
		_update_sprite_direction()
	elif body.name == "Player":
		get_tree().reload_current_scene()

func _update_sprite_direction():
	$AnimatedSprite.flip_h = direction == -1


