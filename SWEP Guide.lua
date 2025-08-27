AddCSLuaFile()

if engine.ActiveGamemode() ~= 'terrortown' then
	SWEP.PrintName = 'Weapon Title'
	
	SWEP.Author = "author"
	SWEP.Purpose = "Its a wepon"
	SWEP.Instructions = "schut gun"
	
	SWEP.Category = "Other"
	SWEP.Spawnable = true
	SWEP.AdminOnly = false
	
	SWEP.Base = 'weapon_base'
	
	SWEP.Slot = 4
	SWEP.SlotPos = 4
	
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
	SWEP.Weight = 1
else
	SWEP.PrintName = 'Weapon Title"
	SWEP.Base = 'weapon_base'
	SWEP.Slot = 7
	SWEP.Icon = 'vgui/ttt/icon.png'
	
	SWEP.EquipMenuData = {
		type = 'item_weapon',
		name = 'weap_name',
		desc = 'weap_desc'
	}
	
	SWEP.Kind = WEAPON_EQUIP1
	SWEP.CanBuy = { ROLE_TRAITOR }
	SWEP.LimitedStock = true
	
	SWEP.AllowDrop = false
	SWEP.NoSights = true
end

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 62
SWEP.ViewModel = Model('model/weapon/weponmodel.mdl')
SWEP.WorldModel = Model('models/Items/gloablweaponmodel.mdl')

SWEP.HoldType = 'normal'
SWEP.UseHands = 'true'
SWEP.FiresUnderwater = true

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

if CLIENT then
	SWEP.BounceWeaponIcon = false
	SWEP.WepSelectIcon = surface.GetTExtureID('vgui/entities/weapon.vtf')
	killicon.Add('weapon_ttt_smite', 'hud/killicons/weapon.vtf', Color(255,80,0,255))
end

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = 'AR2AltFire'
SWEP.Primary.Delay = 10

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = 'none'
SWEP.Secondary.Delay = 999

function SWEP:Initialize()

end

function SWEP:SetupDataTables()

end

function SWEP:Primary()

end

function SWEP:SecondaryAttack()

end

function SWEP:Think()

end

function SWEP:Charge()

end

function SWEP:Custom()

end
