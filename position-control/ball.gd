extends RigidBody3D

var force = 0.0

var target_speed = 0.25 # m/s
var current_speed
var error
var acc = 0.0
var KP_speed = 5.0
var KI_speed = 0.005


var target_position = 0
var current_position
var position_error
var KP_position = 0.5
var V_MAX = 0.5 # m/s

var time = 0.0

@onready var ball_speed: Label = $"../BallSpeed"
@onready var ball_position: Label = $"../BallPosition"
@onready var current_time: Label = $"../CurrentTime"
@onready var position_set_point: LineEdit = $"../PositionSetPoint"
@onready var set_new_position: Button = $"../SetNewPosition"

func _ready() -> void:
	set_new_position.pressed.connect(on_set_new_position_pressed)

func on_set_new_position_pressed():
	target_position = float(position_set_point.text)

func _process(delta: float) -> void:
	time = time + delta
		
	ball_speed.text = "Speed:" + str(linear_velocity.x)
	ball_position.text = "Position:" + str(position.x)
	current_time.text = "Time:" + str(time)
	
	# Position Controller
	current_position = position.x
	position_error = target_position - current_position
	target_speed = position_error * KP_position
	if target_speed > V_MAX:
		target_speed = V_MAX
	
	
	# Speed Controller
	current_speed = linear_velocity.x
	error = target_speed - current_speed
	acc = acc + error * KI_speed
	force = error * KP_speed + acc
	apply_central_force(Vector3(force, 0, 0))
