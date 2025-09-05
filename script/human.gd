extends CharacterBody2D

@onready var human_ui: AnimatedSprite2D = $AnimatedSprite2D
@onready var hp: ProgressBar = $HP

@onready var timer_die: Timer = $"timer-die"
# moster

const SPEED = 120.0

var moster_ui : CharacterBody2D = null 

var action = randi_range(1,2) 

var is_move : bool= false
var move_distance: float = 450.0   # jarak yang harus ditempuh
var moved: float = 0.0             # berapa jauh sudah bergerak

var dirs = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
var direction_move = Vector2.ZERO
## function pelengkap , 
# HP nerima dari signal
func  die(HP):
	if HP <= 0 :
		timer_die.start()
		print("human  die")
		#human_ui.play("die")
func update_hp(Hp)->void :
	hp.value = Hp

func randomize_direction_move() -> void:
	direction_move = dirs[randi() % dirs.size()]

func _on_timer_timeout() -> void:
	#var coundown = 5
	#print("timer jalana")
	#if coundown > 0 :
		#coundown -= 1 # turunkan
	#else :
		#timer.stop() #hentikan loop
	queue_free() # nantikl jika ada masalah sesauikan dengan human di node



func _ready() -> void:
	HumanController.Human_HP.connect(die)
	HumanController.Human_HP.connect(update_hp)
	randomize_direction_move()
	#HumanController.monster_position_updated.connect(on_monster_position_updated)
	#HumanController.monster_position_updated.connect(Callable(self, "_on_monster_position_updated"))

func _on_area_deteksi_body_entered(body: Node2D) -> void:
# ketika masuk arean deteksi
	if  body is CharacterBody2D and body.name == "monster":
		moster_ui = body # asssigment untuk moster yg masuk
		is_move = true 
func _on_area_deteksi_body_exited(body: Node2D) -> void:
# ketika keluar area deteksi
	if body.name == "monster":
		is_move = false
func _physics_process(delta: float) -> void:

	if is_move  && action == 1:
		var velocity = direction_move * SPEED * delta
		position += velocity
		moved += velocity.length()
		# Animasi sesuai arah
		if direction_move.y < 0:
			human_ui.play("runUp")
		elif direction_move.y > 0:
			human_ui.play("runDown")
		elif direction_move.x > 0:
			human_ui.play("runX")
			human_ui.flip_h = false
		elif direction_move.x < 0:
			human_ui.play("runX")
			human_ui.flip_h = true
		# Berhenti kalau sudah sampai jarak tujuan
		if moved >= move_distance:
			is_move = false
			moved = 0.0
			randomize_direction_move() # sesuakan arah baru
			human_ui.play("idle")   # ganti ke animasi diam
	elif is_move && action == 2 :
		#print("Human:", position, " Monster:", HumanController.monster_position, " Direction:", (HumanController.monster_position - position).normalized())
		#human_ui.position += (HumanController.monster_position  - human_ui.position ) / SPEED
		print("moster position : ",HumanController.monster_position , " human position :",position)
		#position = position.move_toward(HumanController.monster_position, SPEED * get_process_delta_time())
		#print("Human:", position, 
	  #" Monster:", HumanController.monster_position, 
	  #" Direction:", direction_move, 
	  #" Distance:", position.distance_to(HumanController.monster_position))
		var direection_attack = (moster_ui.position - position).normalized()
		velocity = direection_attack * SPEED
		move_and_slide()
		human_ui.play("run-attack-top")
	else :
		human_ui.play("idle")
	
