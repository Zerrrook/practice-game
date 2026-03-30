extends CharacterBody2D
class_name Slime
var speed : float = 30

@onready var ray_right: RayCast2D = $RayCast/RayRight
@onready var ray_left: RayCast2D = $RayCast/RayLeft
@onready var ray_right_wall: RayCast2D = $RayCast/RayRightWall
@onready var ray_left_wall: RayCast2D = $RayCast/RayLeftWall


#1 = right, -1 = left
@export_range (-1, 1) var direction: int = 1

func _ready() -> void:
	if direction == 0:
		direction = 1
	$AnimatedSprite2D.flip_h = direction == -1 
	
func _physics_process(delta: float) -> void:
	
#	Go Left
	if direction == 1 and (!ray_right.is_colliding() or ray_right_wall.is_colliding()):
		$AnimatedSprite2D.flip_h = true
		direction = -1
#	Go Right
	if direction == -1 and (!ray_left.is_colliding() or ray_left_wall.is_colliding()):
		$AnimatedSprite2D.flip_h = false
		direction = 1
	
	velocity.x = lerp(velocity.x, direction * speed, 10.0*delta)
	velocity += get_gravity() * delta
	move_and_slide()
	
