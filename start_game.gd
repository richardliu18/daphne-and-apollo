extends CanvasLayer

@onready var main: Node2D = $".."
@onready var map: Node2D = $"../Map"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	main.gameState = main.GameState.PLAY
	print("start button clicked")
	main.update_ui() # Replace with function body.
	
