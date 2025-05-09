local ITEM = {}

ITEM.UniqueID = "food_watersparkling"
ITEM.Name = "Sparkling Water"
ITEM.Desc =  "A can of UU issued sparkling water. Can be purchased from a vending machine."
ITEM.Category = "Food"
ITEM.Model = Model("models/props_cunk/popcan01a.mdl")
ITEM.FOV = 18
ITEM.Weight = 0.4

ITEM.Droppable = true
ITEM.DropOnDeath = false

ITEM.Illegal = false
ITEM.CanStack = true

ITEM.UseName = "Pour into barrel"
ITEM.UseWorkBarTime = 2
ITEM.UseWorkBarName = "Pouring..."
ITEM.UseWorkBarFreeze = true
ITEM.UseWorkBarSound = "impulse/craft/water/1.wav"

function ITEM:OnUse(ply, ent)
    if ent:CanPutRecipe(1) then
        ent:PutRecipe(1)
        return true
    else
        ply:Notify("You are unable to add more water.")
    end
    return false
end

function ITEM:ShouldTraceUse(ply, ent)
    return ent:GetClass() == "impulse_brewing_barrel"
end


impulse.RegisterItem(ITEM)
