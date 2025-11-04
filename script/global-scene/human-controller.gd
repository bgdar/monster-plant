extends Node2D


# random hp untuk human
var HP : int = randi_range(80,100)
signal Human_HP(HP)


func human_attack(currentAttack : int) -> void:
	"""update hp human"""
	HP -= currentAttack
	emit_signal("Human_HP",HP)
	
	
	

func _ready() -> void:
	randomize() # biar randi_range selalu acak tiap run


# ! TIDAK SAYA GUNAKAN LAGI KARENA SAYA MANUAL SAJA ATUR NYA
#func spawn(jumlah:int,perent : Node2D,alas :TileMapLayer) -> void :
	#"membuat jumlah human ke Node2d"
## ambil area cell yang terpakai
	#var used_rect: Rect2i = alas.get_used_rect()
	#
	#if used_rect.size == Vector2i.ZERO:
		#print("⚠️ TileMapLayer kosong, tidak ada area spawn!")
		#return
	## konversi cell ke pixel (ukuran dunia)
	#var tile_size: Vector2i = alas.tile_set.tile_size
	#var pixel_rect := Rect2(
		#used_rect.position * tile_size,
		#used_rect.size * tile_size
	#)
	##print("Area pixel untuk spawn:", pixel_rect)
	## spawn sejumlah human di area pixel
	#for i in range(jumlah):
		#var human_copy = human.instantiate()
		#var margin = 32  # satu tile
		#var x = randi_range(int(pixel_rect.position.x + margin), int(pixel_rect.end.x - margin))
		#var y = randi_range(int(pixel_rect.position.y + margin), int(pixel_rect.end.y - margin))
		#human_copy.global_position = Vector2(x,y)
		#perent.add_child(human_copy)
