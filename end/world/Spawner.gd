extends Node2D

const ENEMY = preload('res://enemies/small/normal/EnemyNormal.tscn')
const ENEMY_ENRAGED = preload('res://enemies/small/enraged/EnemyEnraged.tscn')
export var START_DELAY = 5.0
export var START_MIN_WAIT_TIME = 4.0

var min_wait_time = START_MIN_WAIT_TIME

func _ready():
	randomize()
	$Timer.wait_time = START_DELAY
	$Timer.start()
	

func _on_Pit_enemy_fell():
	var new_enemy = ENEMY_ENRAGED.instance()
	new_enemy.connect('died', self, '_on_enemy_died')
	add_child(new_enemy)

func _spawn_enemy():
	var new_enemy = ENEMY.instance()
	new_enemy.connect('died', self, '_on_enemy_died')
	add_child(new_enemy)

func _set_wait_time():
	$Timer.wait_time = rand_range(min_wait_time, min_wait_time + min_wait_time * 0.5)
	$Timer.start()

func _on_Timer_timeout():
	print('timeout')
	_spawn_enemy()
	_set_wait_time()

func _on_enemy_died():
	min_wait_time -= 0.25
	if min_wait_time <= START_MIN_WAIT_TIME / 2:
		min_wait_time = START_MIN_WAIT_TIME / 2
