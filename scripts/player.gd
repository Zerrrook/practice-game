extends CharacterBody2D
class_name Player

# Turn nodes into variables
@onready var player_health_component: PlayerHealthComponent = $PlayerHealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var knockback_component: KnockbackComponent = $KnockbackComponent

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $FSM
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var respawn_timer: Timer = $RespawnTimer

var pending_hit : Dictionary = {}
var dying := false

func _ready() -> void:
	# Allows the player get "controlled" by the states
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_player_died() -> void:
	dying = true

func _on_hit(hit_data: Variant) -> void:
	pending_hit = hit_data
