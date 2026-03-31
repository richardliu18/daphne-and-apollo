extends Node2D

@onready var start_game: CanvasLayer = $StartGame
@onready var tree_end_game: CanvasLayer = $TreeEndGame
@onready var apollo_end_game: CanvasLayer = $ApolloEndGame
@onready var map: Node2D = $Map



enum GameState{
	START,
	PLAY,
	TREE_END,
	APOLLO_END
}

var gameState = GameState.START
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	start_game.process_mode = Node.PROCESS_MODE_ALWAYS
	tree_end_game.process_mode = Node.PROCESS_MODE_ALWAYS
	apollo_end_game.process_mode = Node.PROCESS_MODE_ALWAYS
	update_ui() # Replace with function body.


func update_ui():
	match gameState:
		GameState.START:
			get_tree().paused = true
			start_game.show()
			map.hide()
			tree_end_game.hide()
			apollo_end_game.hide()

		GameState.PLAY:
			get_tree().paused = false
			start_game.hide()
			map.show()
			tree_end_game.hide()
			apollo_end_game.hide()

		GameState.TREE_END:
			get_tree().paused = true
			start_game.hide()
			map.hide()
			tree_end_game.show()
			apollo_end_game.hide()
		GameState.APOLLO_END:
			get_tree().paused = true
			start_game.hide()
			map.hide()
			tree_end_game.hide()
			apollo_end_game.show()

func set_state(new_state):
	gameState = new_state

	if gameState == GameState.PLAY:
		get_tree().paused = false
	else:
		get_tree().paused = true
		
	update_ui()
		
