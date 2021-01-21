extends Node2D

var items_selected = 0
var current_items = []
var evidence = 0

const fingerprints = 1
const freezingtemps = 2
const book = 4
const emf = 8
const orbs = 16
const spiritbox = 32

const number_to_evidence_name = {
		1: "Fingerprints",
		2: "Freezing Temperatures",
		4: "Ghost Writing",
		8: "EMF Level 5",
		16: "Ghost Orbs",
		32: "Spiritbox"
}

const ghosts = [
	["Banshee", emf + freezingtemps + fingerprints], 
	["Demon", freezingtemps + book + spiritbox],
	["Jinn", emf + orbs + spiritbox],
	["Mare", fingerprints + orbs + spiritbox],
	["Oni", emf + book + spiritbox], 
	["Phantom", emf + freezingtemps + orbs], 
	["Poltergeist", fingerprints + orbs + spiritbox], 
	["Revenant", emf + fingerprints + book], 
	["Shade", emf + orbs + book], 
	["Spirit", fingerprints + book + spiritbox], 
	["Wraith", fingerprints + freezingtemps + spiritbox], 
	["Yurei", freezingtemps + orbs + book]
]

func index_to_evidence(index_number):
	match index_number:
		0:
			return fingerprints
		1:
			return freezingtemps
		2:
			return book
		3:
			return emf
		4:
			return orbs
		5:
			return spiritbox

func possible_outcomes():
	var evidence_text = ""
	print(evidence)
	for ghost in ghosts:
		if (ghost[1] & evidence) == evidence:
			evidence_text += ghost[0] + "\n"
	return evidence_text

func _on_Evidence_List_item_activated(index):
	if get_node("Evidence_List").get_item_custom_bg_color(index) == Color(0, 1, 0, 1):
		get_node("Evidence_List").set_item_custom_bg_color(index, Color(0, 0, 0, 1))
		items_selected -= 1
		current_items.erase(index)
		evidence -= index_to_evidence(index)
		get_node("Evidence_Outcomes").text = possible_outcomes()
	else:
		if items_selected <= 2:
			get_node("Evidence_List").set_item_custom_bg_color(index, Color(0, 1, 0, 1))
			items_selected += 1
			current_items.append(index)
			evidence += index_to_evidence(index)
			get_node("Evidence_Outcomes").text = possible_outcomes()
	pass
