extends KinematicBody2D

export var SPEED = 500
export var GRAVITY = 750
export var JUMP_FORCE = 1500
export var VELOCITY_CHANGE_RATE = 7500

var y_force = GRAVITY

var motion = Vector2()
var jumping = false

onready var animated_sprite = $AnimatedSprite

func _physics_process(delta):
	motion = Vector2()
	var animation = 'idle' if is_on_floor() else 'fall'
	
	if Input.is_action_pressed('move_left'):
		animated_sprite.flip_h = true
		motion.x = -SPEED
		animation = 'run'
		$Gun.position.x = -abs($Gun.position.x)
		$Gun.scale.x = -1
	elif Input.is_action_pressed('move_right'):
		animated_sprite.flip_h = false
		motion.x = SPEED
		animation = 'run'
		$Gun.position.x = abs($Gun.position.x)
		$Gun.scale.x = 1
	
	if Input.is_action_just_pressed('jump') and is_on_floor():
		y_force = -JUMP_FORCE
		jumping = true
		animation = 'jump'
	
	if jumping:
		y_force += VELOCITY_CHANGE_RATE * delta
		if y_force >= 0:
			y_force = 0
			jumping = false
	elif y_force != GRAVITY:
		animation = 'fall'
		y_force += VELOCITY_CHANGE_RATE * delta
		if y_force >= GRAVITY:
			y_force = GRAVITY
	
	motion.y = y_force
	
	move_and_slide(motion, Vector2(0, -1))
	animated_sprite.play(animation)
	