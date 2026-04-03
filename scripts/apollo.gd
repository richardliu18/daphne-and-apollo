extends CharacterBody2D

@export var speed: float = 155

@onready var player = get_node("../Player")
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var target_to_chase: CharacterBody2D

@onready var apollo: NavigationAgent2D = $NavigationAgent2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var anim_state: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var main = get_node("/root/Main")

var move_direction: Vector2 = Vector2.ZERO


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
	
	apollo.target_position = player.global_position

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		print("Hit:", body.name)
		if body == player:
			print("end game")
			main.set_state(main.GameState.APOLLO_END)
	
	
	var direction = global_position.direction_to(apollo.get_next_path_position())

	velocity = direction * speed
	move_and_slide()

	var running_dir = direction.normalized()
	running_dir.y *= -1
	animation_tree.set("parameters/running/running/blend_position", running_dir)
	
	sprite_2d.flip_h = running_dir.x < 0 and abs(running_dir.x) >= abs(running_dir.y)
