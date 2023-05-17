extends TextureButton

var number

signal tile_pressed
signal slide_completed

# update number of the tile
func set_text(new_number):
	number = new_number
	$Number/Label.text = str(number)

# update the background image of the tile
func set_sprite(new_frame, _size, tile_size):
	var sprite = $Sprite
	
	update_size(_size, tile_size)
	
	sprite.set_hframes(_size)
	sprite.set_vframes(_size)
	sprite.set_frame(new_frame)

# scale to the new tile_size
func update_size(_size, tile_size):
	var new_size = Vector2(tile_size, tile_size)
	set_size(new_size)
	$Number.set_size(new_size)
	$Number/ColorRect.set_size(new_size)
	$Number/Label.set_size(new_size)
	$Border.set_size(new_size)
	
	var to_scale = _size * (new_size / $Sprite.texture.get_size())
	$Sprite.set_scale(to_scale)

# update the entire background image
func set_sprite_texture(texture):
	$Sprite.set_texture(texture)

# slide the tile to a new position
func slide_to(new_position, duration):
	var tween = get_tree().create_tween()
	tween.finished.connect(_on_tween_tween_completed)
	tween.tween_property(self, "rect_position", new_position, duration)

# hide/show the number of the tile
func set_number_visible(state):
	$Number.visible = state

# tile is pressed
func _on_tile_pressed():
	emit_signal("tile_pressed", number)

# tile has finished sliding
func _on_tween_tween_completed(_object, _key):
	emit_signal("slide_completed", number)
