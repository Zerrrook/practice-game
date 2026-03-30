extends State
class_name PlayerState

# Declaration of variables
var movement : float
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

# Applies gravity and slide to states that need them
func apply_gravity_and_move(delta): 
	player.velocity.y += gravity * delta
	player.move_and_slide()

# If direction < 0, flip the sprite
func animation_flipping(direction):
	player.animated_sprite.flip_h = direction < 0 
