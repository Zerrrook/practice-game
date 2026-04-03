extends CharacterBody2D
class_name Slime

@export_range(-1,1) var direction: int
@onready var ray_right_ground: RayCast2D = $RayCast/RayRightGround
@onready var ray_left_ground: RayCast2D = $RayCast/RayLeftGround
@onready var ray_right_wall: RayCast2D = $RayCast/RayRightWall
@onready var ray_left_wall: RayCast2D = $RayCast/RayLeftWall

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $FSM

func _ready() -> void:
	# Allows the player get "controlled" by the states
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
