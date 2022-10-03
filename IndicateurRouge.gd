extends Node2D


var length: float = 20.0


func _draw():
	self.draw_line(Vector2(0,0), Vector2(0, -self.length), Color.red, 3.0)
