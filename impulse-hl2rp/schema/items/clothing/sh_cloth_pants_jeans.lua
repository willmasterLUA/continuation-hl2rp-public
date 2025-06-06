local ITEM = {}

ITEM.UniqueID = "cos_pants_jeans"
ITEM.Name = "Jeans"
ITEM.Desc =  "A pair of classic blue denim jeans with a straight-leg cut, five-pocket styling, a button fly, and visible wear."
ITEM.Category = "Clothing"
ITEM.Model = Model("models/props_c17/BriefCase001a.mdl")
ITEM.FOV = 54.231758109009
ITEM.CamPos = Vector(24.443738937378, 7.1889691352844, 10.658709526062)
ITEM.NoCenter = true
ITEM.Weight = 0.1

ITEM.BodygroupID = 2 -- What Bodygroup ID?
ITEM.Bodygroup = 6 --  Bodygroup Slot

ITEM.Droppable = true
ITEM.DropOnDeath = true

ITEM.Illegal = false
ITEM.Equipable = true
ITEM.EquipGroup = "pants"
ITEM.CanStack = true

function ITEM:CanEquip(ply)
	local teamblacklist = { [TEAM_CA] = true, [TEAM_VORT] = true,}
	if ply:IsCP() or teamblacklist[ply:Team()] then
		return false
	else
		return true
	end
end

function ITEM:OnEquip(ply)
	ply:SetBodygroup(ITEM.BodygroupID, ITEM.Bodygroup)
end

function ITEM:UnEquip(ply)
	ply:SetBodygroup(ITEM.BodygroupID, 0)
end

impulse.RegisterItem(ITEM)
