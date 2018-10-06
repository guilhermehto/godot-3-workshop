extends Area2D

const DAMAGE = 50
const SPEED = 1500

var direction = 0

func _ready():
	set_as_toplevel(true)
	connect('body_entered', self, '_on_body_entered')

func init(direction):
	self.direction = direction

func _physics_process(delta):
	position.x += SPEED * direction * delta
	
func _on_body_entered(body):
	if body.is_a_parent_of(self):
		return
	if body.is_in_group('enemies'):
		body.damage(DAMAGE)
	queue_free()
