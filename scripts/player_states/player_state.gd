extends State
class_name PlayerState

# Declaration of variables
var movement : int
var coyote_timer_activated := false
var damage : int
var knockback_direction : Vector2

@export var speed = 100.0
@export var jump_velocity = 250.0
@export var player : Player
@export var animation_name : String

# Overrides the enter() function from the state class
func enter():
	player.animated_sprite.play(animation_name) # Used when super() is called
	pass
