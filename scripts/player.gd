extends CharacterBody2D

	
enum State{
	IDLE,
	RUN,
	ATTACK,
	DEAD,
}

@export_category("Stats")
@export var speed: int = 150

var state: State = State.IDLE
var move_direction: Vector2 = Vector2.ZERO
var attack_speed: float = 0.6

@onready var water: TileMapLayer = $"../Water"
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var pray: Label = $Pray
@onready var main: Node2D = $"../.."


func _physics_process(delta: float) -> void:
	if not state== State.ATTACK:
		movement_loop()
	
	

func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#attack()
	return

func movement_loop() -> void:
	
	move_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	move_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	var motion: Vector2 = move_direction.normalized() * speed
	velocity = motion
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		#print("Hit:", body.name)
		if body == water:
			#print("pray")
			main.set_state(main.GameState.PRAYER)
			if Input.is_action_just_pressed("enter"):
				main.set_state(main.GameState.TREE_END)
		else:
			main.set_state(main.GameState.PLAY)

	if motion != Vector2.ZERO:
		# Always in RUN while moving
		if state != State.RUN:
			state = State.RUN
			update_animation()
		
		var running_dir: Vector2 = motion.normalized()
		
		animation_tree.set("parameters/running/Running/blend_position", running_dir)
		
		$Sprite2D.flip_h = running_dir.x < 0 and abs(running_dir.x) >= abs(running_dir.y)

	else:
		if state != State.IDLE:
			state = State.IDLE
			update_animation()
	
func attack() -> void:
	if state==State.ATTACK:
		return
	state = State.ATTACK
	
	var mouse_pos: Vector2 = get_global_mouse_position()
	var attack_dir: Vector2 = (mouse_pos - global_position).normalized()
	$Sprite2D.flip_h = attack_dir.x <0 and abs(attack_dir.x) >=abs(attack_dir.y)
	animation_tree.set("parameters/attack/BlendSpace2D/blend_position", attack_dir)
	update_animation()
		
	await get_tree().create_timer(attack_speed).timeout
	state = State.IDLE
	
func update_animation()->void:
	match state:
		State.IDLE:
			animation_playback.travel("idle")
		State.RUN:
			animation_playback.travel("running")
		State.ATTACK:
			animation_playback.travel("attack")
			
	
