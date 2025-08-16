extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -500.0
@onready var moster_ui: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	## Add the gravity.kita tidak perlu grafitasi di game 2d top dowm
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	#
	##validasi animasi untuk mosternya 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction:
		velocity = direction * SPEED # jalan antara atas atau bawah 
		#velocity.x = direction * SPEED
		if direction.y < 0 :
			moster_ui.animation = "runTop"
		elif direction.y > 0 :
			moster_ui.animation = "runDown"
		else:
			moster_ui.animation = "runX"
			
		moster_ui.flip_h = direction[0] < 0 # balik badan
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y,0,SPEED)
		moster_ui.animation = "idle"

	move_and_slide()
