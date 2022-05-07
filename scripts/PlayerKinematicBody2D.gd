extends KinematicBody2D

const PLAYER_MOVEMENT_MAX_SPEED = 90
const ACCELERATE = 400
const FRICTION = 600

var playerVelocity = Vector2.ZERO

onready var playerAnimation = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(_delta):
	var result = Vector2.ZERO
	result.x = Input.get_action_strength("keyboard_d") - Input.get_action_strength("keyboard_a")
	result.y = Input.get_action_strength("keyboard_s") - Input.get_action_strength("keyboard_w")
	result = result.normalized()

	if result != Vector2.ZERO:
		animationTree.set("parameters/running/blend_position", result)
		animationTree.set("parameters/idle/blend_position", result)

		playerVelocity = playerVelocity.move_toward(result * PLAYER_MOVEMENT_MAX_SPEED, ACCELERATE * _delta)
		animationState.travel("running")
	else:
		playerVelocity = playerVelocity.move_toward(Vector2.ZERO, FRICTION * _delta)

		animationState.travel("idle")


	return move_and_slide(playerVelocity)
