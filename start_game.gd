extends CanvasLayer

@onready var main: Node2D = $".."
@onready var map: Node2D = $"../Map"


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	main.gameState = main.GameState.PLAY
	
	print("start button clicked")
	main.update_ui()
	
