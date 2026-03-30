extends CharacterBody2D

@export var speed: float = 148

@onready var player = get_node("../Player")

@export var target_to_chase: CharacterBody2D

@onready var apollo: NavigationAgent2D = $NavigationAgent2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var anim_state: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
 
func _ready():
	if player == null:
		player = $"../Player"
	set_physics_process(false)
	call_deferred("wait_for_physics")
	apollo.path_desired_distance = 1   # small distance for precise movement
	apollo.target_desired_distance = 1
	anim_state.travel("idle")  # always play idle animation
	

func wait_for_physics():
	await get_tree().physics_frame
	set_physics_process(true)
	
	
func _physics_process(delta: float) -> void:
	
	if apollo.is_navigation_finished() and target_to_chase.global_position == apollo.target_position:
		endGame()
			
	apollo.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(apollo.get_next_path_position()) * speed
	move_and_slide()
	
func endGame():
	return
