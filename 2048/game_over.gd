extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayAgainButton.disabled = true
	$QuitButton.disabled = true
	await get_tree().create_timer(2.0).timeout
	$PlayAgainButton.disabled = false
	$QuitButton.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_again_button_pressed():
	Global.defeat = false
	get_tree().paused = false
	queue_free()


func _on_quit_button_pressed():
	get_tree().quit()
