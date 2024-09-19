extends Node3D

var value
# Called when the node enters the scene tree for the first time.
func _ready():
	value = randi_range(1, 10)
	$NumberLabel.text = str(value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_3d_body_entered(body):
	if body.name.match("Player"):
		
		Global.score = value
		Global.collided = true
		Global.food_population -= 1
		Global.eaten += 1
	queue_free()
