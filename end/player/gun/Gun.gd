extends Sprite

var BULLET = preload('res://player/gun/Bullet.tscn')

func _process(delta):
	if Input.is_action_pressed('shoot') and $Timer.is_stopped():
		$Timer.start()
		var new_bullet = BULLET.instance()
		new_bullet.global_position = $Barrel.global_position
		new_bullet.init(-1 if position.x < 0 else 1)
		add_child(new_bullet)
