local ITEM = {}

ITEM.UniqueID = "cos_shirt_green_jacket"
ITEM.Name = "Green Jacket"
ITEM.Desc =  "A rugged green button-up jacket with a high collar, showing signs of wear, dirt, and fading."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.FOV = 54.231758109009
ITEM.CamPos = Vector(24.443738937378, 7.1889691352844, 10.658709526062)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.BodygroupID = 1 -- What Bodygroup ID?
ITEM.Bodygroup = 4 --  Bodygroup Slot

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "shirt"
ITEM.CanStack = true

function ITEM:CanEquip(ply)
	local teamblacklist = { [TEAM_CA] = true, [TEAM_VORT] = true,}
	if ply:IsCP() or teamblacklist[ply:Team()] or ply.WearingRebelOutfit then
		return false
	else
		return true
	end
end

function ITEM:OnEquip(ply)
	if (not ply.WearingRebelOutfit) then
		ply:SetBodygroup(ITEM.BodygroupID, ITEM.Bodygroup)
	end
end

function ITEM:UnEquip(ply)
	if (not ply.WearingRebelOutfit) then
		ply:SetBodygroup(ITEM.BodygroupID, 0)
	end
end

impulse.RegisterItem(ITEM)
