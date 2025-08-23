extends CharacterBody2D

const speed = 256
const myUp = Vector2(0,-1)
const myDown = Vector2(0,1)
const myLeft = Vector2(-1,0)
const myRight = Vector2(1,0)

func _physics_process(_delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("myUp"):
		direction += myUp
	if Input.is_action_pressed("myDown"):
		direction += myDown
	if Input.is_action_pressed("myLeft"):
		direction += myLeft
	if Input.is_action_pressed("myRight"):
		direction += myRight
	direction = direction.normalized()
	velocity = (direction * speed)
	move_and_slide()
