extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(Global.enemy_name_array_count):
		$ScoresLabel.text = str(Global.enemy_name_array[i], " - ", Global.enemy_score_array[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
