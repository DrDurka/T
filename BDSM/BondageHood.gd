extends ItemBase

func _init():
	id = "BondageHood"

func getVisibleName():
	return "Bondage hood"
	
func getDescription():
	return "Maybe too secure for a head bag"

func getClothingSlot():
	return InventorySlot.Eyes

func getPrice():
	return 20

func getBuffs():
	var buffs = [
		buff(Buff.AmbientLustBuff, [10]),
		buff(Buff.BlindfoldBuff),
		buff(Buff.MuzzleBuff)
		]
	return buffs

func getTags():
	return [ItemTag.BDSMRestraint, ItemTag.SoldByTheAnnouncer, ItemTag.CanBeForcedInStocks]


func isRestraint():
	return true

func generateRestraintData():
	restraintData = RestraintBlindfold.new()
	restraintData.setLevel(5)

func getPuttingOnStringLong(withS):
	if(withS):
		return "puts on your bondage hood"
	else:
		return "put on your bondage hood"
		
func getTakeOffScene():
	return "RestraintTakeOffNopeScene"
	
func getRiggedParts(_character):
	var output = {
		"BondageHood": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood.tscn"
	}
	
	var no_model = ["humanears","dragonears","dragonears2"]
	if GM.main.saveDynamicCharactersData().has(_character):
		var ears = GM.main.saveDynamicCharactersData()[_character]["data"]["bodyparts"]["ears"]["id"]
		if no_model.has(ears) == false:
			output.merge({"BondageHood_ears": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_ears.tscn"},true)
	else:
		var ears = GM.pc.saveData().bodyparts["ears"]["id"]
		if  no_model.has(ears) == false:
			output.merge({"BondageHood_ears": "res://Modules/MoreBDSMstuffModule/Models/BondageHood/BondageHood_ears.tscn"},true)
	return output

func getHidesParts(_character):
	var removed = {}
	
	removed = {
		BodypartSlot.Head: true,
		BodypartSlot.Ears: true,
		BodypartSlot.Hair: true,
	}

	return removed
	
func getTakingOffStringLong(withS):
	if(withS):
		return "takes off your bondage hood"
	else:
		return "take off your bondage hood"

func alwaysVisible():
	return true

func getInventoryImage():
	return "res://Modules/MoreBDSMstuffModule/Models/BondageHood/ico.png"
