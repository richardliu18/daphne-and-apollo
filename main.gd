extends Node2D

@onready var start_game: CanvasLayer = $StartGame
@onready var tree_end_game: CanvasLayer = $TreeEndGame
@onready var apollo_end_game: CanvasLayer = $ApolloEndGame
@onready var map: Node2D = $Map

enum GameState{
	START,
	PLAY,
	END
}

var gameState = GameState.START
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ui() # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_ui()


func update_ui():
	match gameState:
		GameState.START:
			start_game.show()
			map.hide()
			tree_end_game.hide()
			apollo_end_game.hide()

		GameState.PLAY:
			start_game.hide()
			map.show()
			tree_end_game.hide()
			apollo_end_game.hide()

		GameState.END:
			start_game.hide()
			map.hide()
			tree_end_game.hide()
			apollo_end_game.show()

func set_state(new_state):
	gameState = new_state
	update_ui()
