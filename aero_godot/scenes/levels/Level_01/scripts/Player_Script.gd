extends CharacterBody3D



const ship_Acceleration = 3000
const max_speed = 2000



@export var input = Vector3.ZERO

var rotation_Limit = 25.0


var health: set = _set_health, get = _get_health

func _set_health(new_value):
	health += new_value

func _get_health():
	return health
signal health_depleted
var player_hit = false

func _ready() -> void:
	health

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	if input == Vector3.ZERO:
		velocity = Vector3.ZERO
	else:
		velocity = (input * delta * ship_Acceleration)
		velocity.limit_length(max_speed)
	modelRotation(input)
	move_and_slide()

func modelRotation(input):
	"""
	Function for rotating model towards the movement direction, otherwise
	resetting to the default
	"""
	
	#x rotation

	if(input.x < 0 && rotation.y < 0.3):
		rotation.y += .05
	if(input.x > 0 && rotation.y > -0.3):
		rotation.y -= .05
	elif (input.x == 0):
		rotation = rotation.lerp(Vector3(rotation.x,0,rotation.z),0.03) 	
		
		#y rotation
	if(input.y < 0 && rotation.x > - 0.3):
		rotation.x -= .05
	if(input.y > 0 && rotation.x < 0.3):
		rotation.x += .05
	elif (input.y == 0):
		rotation = rotation.lerp(Vector3(0,rotation.y,rotation.z),0.03) 	
		
	rotation.clampf(-.06,.06)


func take_damage():
	health -=1
	
	if health <= 0:
		health_depleted.emit()
	else: 
		player_hit = true


func _physics_process(delta: float):
	if(player_hit):
		print("you've been hit!")
		#insert spin here
		player_hit = false
	else:
		player_movement(delta)
	
