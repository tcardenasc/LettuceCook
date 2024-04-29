extends TextureRect

@onready var viewport = get_node("../../SubViewport")

func _process(delta):
	texture = viewport.get_texture()
