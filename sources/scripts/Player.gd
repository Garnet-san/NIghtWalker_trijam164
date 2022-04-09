extends KinematicBody2D

var speed = 60
var gravity = 5
var jumpPower = 50
var pressed = false

var motion = Vector2.ZERO

onready var animation_state = $AnimationTree.get("parameters/playback")

var state
enum states {
	idle,
	idlenight,
	gettingreadyforjump,
	readyforjump, 
	jump,
	fall,
	landing,
	walikng
}

func _ready():
	state = states.idle
	GlobalValues.playerStartPos = position
	print(GlobalValues.playerStartPos)

func _physics_process(delta):
	var direction = 0
	match state:
		states.idle:
			animation_state.travel("idle")
			if Input.is_key_pressed(KEY_UP)  && is_on_floor() && GlobalValues.day:
				state = states.gettingreadyforjump
			if motion.y <= -5:
				state = states.fall
		states.gettingreadyforjump:
			animation_state.travel("gettingreadyforjump")
		states.jump:
				animation_state.travel("jump")
				if motion.y <= 5:
					state = states.fall
		states.fall:
			animation_state.travel("fall")
			if is_on_floor():
				state = states.landing
		states.landing:
			animation_state.travel("landing")
		states.idlenight:
			animation_state.travel("idlenight")
			if (Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_RIGHT)) && !GlobalValues.day:
				state = states.walikng
		states.walikng:
			animation_state.travel("walking")
			if direction == 0:
				state = states.idlenight
				


	
	
	if Input.is_key_pressed(KEY_LEFT) && !GlobalValues.day:
		direction -= 1
	if Input.is_key_pressed(KEY_RIGHT) && !GlobalValues.day:
		direction += 1
	if direction == 0 && !GlobalValues.day:
		motion.x = 0
	elif !GlobalValues.day:
		motion.x = direction * speed
	if Input.is_key_pressed(KEY_UP) && is_on_floor() && GlobalValues.day:
		jumpPower += 5
		pressed = true
		if jumpPower >= 200:
			jumpPower = 200
	elif jumpPower > 50 && GlobalValues.day:
		state = states.jump
		motion.y = -jumpPower
		jumpPower = 50
	if GlobalValues.day:
		get_parent().get_node("Controlls_hint/Arrow_up2").visible = true
		get_parent().get_node("Controlls_hint/Arrow_side").visible = false
		get_parent().get_node("Controlls_hint/Arrow_side2").visible = false
		if state == states.idlenight or state == states.walikng:
			state = states.idle
		motion.y += gravity
		motion.x = 0
	else:
		get_parent().get_node("Controlls_hint/Arrow_up2").visible = false
		get_parent().get_node("Controlls_hint/Arrow_side").visible = true
		get_parent().get_node("Controlls_hint/Arrow_side2").visible = true
		if state != states.idlenight or state != states.walikng:
			state = states.idlenight
		motion.y = 0
	motion = move_and_slide(motion, Vector2.UP)
	if state == states.landing && is_on_floor():
		state = states.idle
		animation_state.travel("idle")


func _on_AnimationPlayer_animation_finished(anim_name:String):
	match state:
		states.gettingreadyforjump:
			state = states.readyforjump
			animation_state.travel("readyforjump")
