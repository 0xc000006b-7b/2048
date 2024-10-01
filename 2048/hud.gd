extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$KeyboardButton.visible = false
	$MouseButton.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_game_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


func _on_setting_button_pressed():
	if not $KeyboardButton.visible:
		$KeyboardButton.visible = true
		$MouseButton.visible = true
	else:
		$KeyboardButton.visible = false
		$MouseButton.visible = false


func _on_keyboard_button_pressed():
	Global.change_controller = true


func _on_mouse_button_pressed():
	Global.change_controller = false
