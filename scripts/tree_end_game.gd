extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func show_game_over():
	show()
	get_tree().paused = true


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene() # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()
