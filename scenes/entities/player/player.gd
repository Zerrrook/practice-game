extends CharacterBody2D
class_name Player

# Turn nodes into variables
@onready var player_health_component: PlayerHealthComponent = $PlayerHealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var knockback_component: KnockbackComponent = $KnockbackComponent
@onready var move_component: MoveComponent = $MoveComponent

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: Node = $FSM

@onready var coyote_timer: Timer = $CoyoteTimer
@onready var respawn_timer: Timer = $RespawnTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

@onready var hurt_state: PlayerHurt = $FSM/Hurt
@export var speed = 100.0
@export var jump_velocity = 250.0

var pending_damage : Dictionary = {} # Keys: damage, knockback_direction, is_hazard
var coyote_timer_activated := false
var is_invincible := false
var dying := false
var died := false

#region State-related functions
func _ready() -> void:
	add_to_group("Player")
	# Allows the player get "controlled" by the states
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Heal"):
		player_health_component.heal_hp(1)
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func get_global_state():
	# If alive, Goes to the hit state if the player detects a hit
	if !died:
		if pending_damage:
			return hurt_state
#endregion

#region Player-based functions

func _on_player_died() -> void:
	dying = true

func _on_hit(hit_data: Variant) -> void:
	pending_damage = hit_data

func _on_animation_player_flicker_finished(anim_name: StringName) -> void:
	if anim_name == "flicker_hurt":
		animation_player.play("RESET")
#endregion
