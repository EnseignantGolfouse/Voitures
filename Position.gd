extends Node2D


var unit_length: float = 8.0


func _draw():
	self.draw_line(Vector2(0,0), Vector2(100.0*self.unit_length, 0), Color.white)
	for i in range(0, 11):
		self.draw_line(
			Vector2(10*i*self.unit_length, 0),
			Vector2(10*i*self.unit_length, 20),
			Color.white)
