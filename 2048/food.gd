extends StaticBody3D

var value
var value_array := [2, 4, 6, 8, 16, 32, 64]
var check = false
var food_position = Vector3()
# Called when the node enters the scene tree for the first time.
func _ready():
	value = randi_range(0, 6)
	$NumberLabel.text = str(value_array[value])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not check:
		if Global.enemy_entered_food:
			Global.food_position = self.position
			check = true
		if not Global.food_collided_with_enemy:
			check = false
			
	#print(ping_enemy_self_pos() , " jdawdkawdkajwnjkw")

func _on_area_3d_body_entered(body):
	if body.name.match("Player"):
		
		Global.score = value_array[value]
		Global.food_collided_with_player = true
		Global.food_population -= 1
		Global.eaten += 1
		if Global.food_pos_array.has(self.position):
			Global.food_pos_array.erase(self.position)
		self_destroy()
	#elif body.name.match("Enemy"):
		#Global.enemy_score = value_array[value]
		#Global.food_collided_with_enemy = true
		#Global.food_population -= 1
		#Global.eaten += 1
		#print("Enemy ate me!")
		#queue_free()
		#Global.food_position = self.position

func ping():
	return self.position
	
func return_my_value():
	return value_array[value]
	
func self_destroy():
	queue_free()
