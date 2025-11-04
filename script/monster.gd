extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const ATTACK = 150

@onready var monster_ui: AnimatedSprite2D = $AnimatedSprite2D
@onready var mouster_plant: Node2D = $".."
@onready var human_perent: Node2D = $"../human_perent"
@onready var alas: TileMapLayer = $"../alas"


var is_attack :String= "attackX"

func handle_attack():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "human":
			HumanController.human_attack(ATTACK)

# saat node sudah siap (  fisic sudah ada )
#func _ready() -> void:	
	#HumanController.spawn(30,human_perent,alas)

# dipanggil tiap frame physics ( default 60 fps )
func _physics_process(delta: float) -> void:

	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	# attack sudah di tambahkan di project settinsg
	var  attack := Input.is_action_pressed("attack") # hold ( pendam)
	print("monster position",position)

	if direction:
		velocity = direction * SPEED
		if direction.y < 0:
			is_attack = "attackTop"
			if attack :
				monster_ui.play("attackTop")
				handle_attack()
			else :
				monster_ui.play("runTop")
		elif direction.y > 0:
			is_attack = "attackDown"
			if attack :
				monster_ui.play("attackDown")
				handle_attack()
			else :
				monster_ui.play("runDown")
		else:
			is_attack = "attackX"
			if attack :
				monster_ui.play("attackX")
				handle_attack()
			else :
				monster_ui.play("runX")
		
		monster_ui.flip_h = direction.x < 0
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		monster_ui.play("idle")
	# jalanak untuk sat di tekan "a" biasanya
	if Input.is_action_just_pressed("attack"):
		monster_ui.play(is_attack)
		monster_ui.speed_scale = 2.0
	elif Input.is_action_just_pressed("attack") :#jika tombol di lepas 
		monster_ui.speed_scale = 1.0
	move_and_slide()
