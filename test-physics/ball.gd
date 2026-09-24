extends RigidBody3D

var force = 0.0
var target_speed = 0.25 # m/s
var current_speed
var error
var acc = 0.0
var KP = 5.0
var KI = 0.005
var time = 0.0

@onready var ball_speed: Label = $"../BallSpeed"
@onready var ball_position: Label = $"../BallPosition"
@onready var current_time: Label = $"../CurrentTime"
@onready var speed_set_point: LineEdit = $"../SpeedSetPoint"
@onready var set_new_speed: Button = $"../SetNewSpeed"

func _ready() -> void:
	set_new_speed.pressed.connect(on_set_new_speed_pressed)

func on_set_new_speed_pressed():
	target_speed = float(speed_set_point.text)

func _process(delta: float) -> void:
	time = time + delta
	if Input.is_action_pressed("ui_up"):
		apply_central_impulse(Vector3(0,force,0))
	if Input.is_action_pressed("ui_right"):
		apply_central_impulse(Vector3(0.5,0,0))
	if Input.is_action_pressed("ui_left"):
		apply_central_impulse(Vector3(-0.5,0,0))
		
	ball_speed.text = "Speed:" + str(linear_velocity.x)
	ball_position.text = "Position:" + str(position.x)
	current_time.text = "Time:" + str(time)
	
	current_speed = linear_velocity.x
	error = target_speed - current_speed
	acc = acc + error * KI
	force = error * KP + acc
	apply_central_force(Vector3(force, 0, 0))
