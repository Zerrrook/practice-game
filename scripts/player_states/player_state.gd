extends State
class_name PlayerState

var is_alive := true
var is_hurt := false
var dying := false
var direction := 0
var coyote_timer_activated := false
var damage : int
var knockback_direction : Vector2

@export var speed = 100.0
@export var jump_velocity = -250.0
@export var player : Player

@onready var respawn_timer: Timer = player.get_node("RespawnTimer")
@onready var coyote_timer: Timer = player.get_node("CoyoteTimer")

@onready var animated_sprite: AnimatedSprite2D = player.get_node("AnimatedSprite2D")

#region Player Functions
func gravity(delta):
	if !player.is_on_floor():
		player.velocity += player.get_gravity() * delta

func movement():
	direction = Input.get_axis("move_left", "move_right") # Direction, -1 = left, 1 = right
	#	Applies horizontal based on input
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		
	return direction
	
func handle_animation():
	
	#	Flip sprite based on direction
	if direction == 1:
		animated_sprite.flip_h = false
	if direction == -1:
		animated_sprite.flip_h = true
		
	if player.is_on_floor():
#		Plays idle when stationary and run when moving
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
#endregion
