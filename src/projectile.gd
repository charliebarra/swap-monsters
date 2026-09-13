extends Area2D

const SPEED = 700.0
const RANGE = 5000.0
var travelled_distance = 0.0
var direction: Vector2 = Vector2.RIGHT

func _ready():
	if direction == Vector2.LEFT:
		%Sprite2D.flip_h = true
	else:
		%Sprite2D.flip_h = false
func _physics_process(delta):
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()
	
func _on_body_entered(body):
	queue_free()
	if body.has_method("destroy"):
		body.destroy()
