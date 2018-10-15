extends "res://weigtless/weigtless.gd"

var AstroidSmall = preload ("res://Asteroid/Asteroidsmall.tscn")
var AstroidMeduim = preload ("res://Asteroid/Asteroidmeduim.tscn")

export(float) var explode_force = 300
signal explode

enum Size{
	SMALL,MEDUIM,LARGE
}
export(Size) var size = Size.LARGE
var raduis

func _ready():
	connect("explode",self, "_explode")
	raduis = get_node("Sprite").texture.get_width() /2 * get_node("Sprite").scale
	pass

func _explode():
	if size != Size.SMALL:
		for i in range(0,3):
			var offset_dir = PI * 2 / 3 * i
			var asteroid
			match size:
				MEDUIM:
					asteroid = AstroidSmall.instance()
				LARGE:
					asteroid = AstroidMeduim.instance()
			asteroid.position = position + raduis.rotated(offset_dir)
			asteroid.linear_velocity = linear_velocity + Vector2(explode_force,0).rotated(offset_dir)
			get_parent().add_child(asteroid)
	queue_free()
	sleeping = true
	pass