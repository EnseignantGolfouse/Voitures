extends Control


var y_offset: float = 100.0
const X_OFFSET: float = 100.0

var voiture_rouge_start_pos: Vector2
var voiture_bleue_start_pos: Vector2

var running: bool = false
var voiture_rouge_speed: float = 100.0
var voiture_bleue_speed: float = 120.0
var unit_length: float


func _ready():
	self.set_unit_length(8.0)
	self._on_Reinitialise_pressed()

func set_unit_length(length: float):
	self.unit_length = length
	$Position.unit_length = length
	$Position.update()
	self.voiture_rouge_start_pos = Vector2(X_OFFSET + 20*length, self.y_offset)
	self.voiture_bleue_start_pos = Vector2(X_OFFSET + 6*length, 2*self.y_offset)
	self.voiture_rouge_speed = 100.0 * unit_length
	self.voiture_bleue_speed = 120.0 * unit_length

func _process(delta: float):
	if self.running:
		$VoitureRouge.position.x += delta * 0.1 * self.voiture_rouge_speed
		$VoitureBleue.position.x += delta * 0.1 * self.voiture_bleue_speed
		$IndicateurRouge.position.x = $VoitureRouge.position.x
		$IndicateurBleu.position.x = $VoitureBleue.position.x
		if $VoitureRouge.position.x >= X_OFFSET + 100.0 * self.unit_length:
			self.running = false
		if $VoitureBleue.position.x >= X_OFFSET + 100.0 * self.unit_length:
			self.running = false

func _on_Demarre_pressed():
	self.running = true

func _on_Reinitialise_pressed():
	self.running = false
	$VoitureRouge.position = self.voiture_rouge_start_pos
	$VoitureBleue.position = self.voiture_bleue_start_pos
	$IndicateurRouge.position = Vector2(self.voiture_rouge_start_pos.x, 3*self.y_offset)
	$IndicateurBleu.position = Vector2(self.voiture_bleue_start_pos.x, 3*self.y_offset)
	$Position.position = Vector2(X_OFFSET, 3*self.y_offset)

func _on_Main_resized():
	var size_x = self.rect_size.x
	var size_y = self.rect_size.y
	self.y_offset = size_y / 5
	$IndicateurRouge.length = self.y_offset / 5.0
	$IndicateurBleu.length = self.y_offset / 5.0
	self.set_unit_length((size_x - 200.0) / 100.0)
	var scale_bleue = 15.0 * self.unit_length / $VoitureBleue.texture.get_size().x
	$VoitureBleue.scale = Vector2(scale_bleue, scale_bleue)
	var scale_rouge = 15.0 * self.unit_length / $VoitureRouge.texture.get_size().x
	$VoitureRouge.scale = Vector2(scale_rouge, scale_rouge)
	self._on_Reinitialise_pressed()

func _on_Pause_pressed():
	self.running = false
