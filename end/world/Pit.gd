extends Area2D

signal enemy_fell

func _ready():
	connect('body_entered', self, '_on_body_entered')

func _on_body_entered(body):
	print(body.name)
	if body.is_in_group('enemies'):
		emit_signal('enemy_fell')
	else:
		get_tree().reload_current_scene()