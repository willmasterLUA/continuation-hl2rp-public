AddCSLuaFile()

SWEP.Base = "ls_base_melee"

SWEP.PrintName = "The Clobberer"
SWEP.Category = "impulse HL2RP Weapons"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "melee2"

SWEP.WorldModel = Model("models/weapons/hl2meleepack/w_pickaxe.mdl")
SWEP.ViewModel = Model("models/weapons/hl2meleepack/v_pickaxe.mdl")
SWEP.CustomMaterial = "models/props_lab/Tank_Glass001"
SWEP.ViewModelFOV = 60

SWEP.Slot = 4
SWEP.SlotPos = 1

--SWEP.LowerAngles = Angle(15, -10, -20)

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("WeaponFrag.Roll")
SWEP.Primary.ImpactSound = Sound("Canister.ImpactHard")
SWEP.Primary.Recoil = 3.2 -- base recoil value, SWEP.Spread mods can change this
SWEP.Primary.Damage = 28 -- not used in this swep
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 1
SWEP.Primary.HitDelay = 0.4
SWEP.Primary.Range = 81
SWEP.Primary.FlashTime = 1.2
SWEP.Primary.FlashColour = Color(226, 88, 34)
SWEP.Primary.HullSize = 7

local CopyViewModelOrigin = SWEP.ViewModelFOV
function SWEP:PostDrawViewModel(viewmodel, player)
    self.ViewModelFOV = CopyViewModelOrigin + impulse.GetSetting("firstperson_fov")
end
