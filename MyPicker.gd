extends Spatial

export(String) var state = ""
export(String) var part = ""

var doll:Spatial

var cachedPart

func _ready():
	
	var Part3D = load("res://Player/Player3D/Parts/Part3D.gd")
	var theNode:Node = self
	
	while !(theNode is Part3D):
		var previousNode = theNode.get_node("..")
		if (previousNode == null || previousNode is Doll3D ):
			break
		if previousNode is Part3D:
			doll = previousNode.getDoll()
		theNode = previousNode
		
	var ch = doll.getCharacterID()
	if(ch == null || ch == ""):
		return null
	
	var part_id = (Check(ch, part))
	var current_part
	
	if ExclusionList.getList()[part].has(part_id):
		current_part = part_id
	elif part != "legs":
		current_part = part_id
	elif part == "legs":
		current_part = doll.state["legstype"]
		if current_part == null:
			return null
	
	setValue(current_part)
	cachedPart = current_part

func _process(_delta):
	
	if doll == null:
		return
	
	var ch = doll.getCharacterID()
	if(ch == null || ch == ""):
		return null
	
	var part_id = (Check(ch, part))
	var currentLegs
	
	
	if ExclusionList.getList()[part].has(part_id):
		currentLegs = part_id
	elif part != "legs":
		currentLegs = part_id
	else:
		currentLegs = doll.state["legstype"]
		if currentLegs == null:
			return null
			
	if cachedPart != currentLegs:
		cachedPart = currentLegs
		setValue(currentLegs)

func setValue(value):
	
	var MyState = load("res://Modules/A_TechnicalModule/MyState.gd")
	var foundSomething = false
	for child in get_children():
		if(child is MyState):
			if(child.getStateValue() == value):
				child.visible = true
				foundSomething = true
			else:
				child.visible = false
	
	if(!foundSomething):
		for child in get_children():
			if(child is MyState):
				if(child.getStateValue() == state):
					child.visible = true
				else:
					child.visible = false

func Check(character, bodypart):
	var id
	if GM.main.saveDynamicCharactersData().has(character):
		id = GM.main.saveDynamicCharactersData()[character]["data"]["bodyparts"][bodypart]["id"]
	else:
		id = GM.pc.saveData().bodyparts[bodypart]["id"]
	return id
