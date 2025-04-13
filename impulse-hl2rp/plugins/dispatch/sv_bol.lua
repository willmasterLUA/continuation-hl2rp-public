impulse.Dispatch = impulse.Dispatch or {}
impulse.Dispatch.BOL = impulse.Dispatch.BOL or {}

util.AddNetworkString("impulseHL2RPSetBOL")
util.AddNetworkString("impulseHL2RPAddBOL")
util.AddNetworkString("impulseHL2RPRemoveBOL")

function meta:AddDispatchBOL(crime, expiry)
	local crimeData = impulse.Config.ArrestCharges[crime]
	local id = self:SteamID()

	if timer.Exists("impulseHL2RPBOLExpire"..self:SteamID()) then
		timer.Remove("impulseHL2RPBOLExpire"..self:SteamID())
	end

	timer.Create("impulseHL2RPBOLExpire"..self:SteamID(), expiry, 1, function()
		impulse.Dispatch.BOL[id] = nil

		local p = player.GetBySteamID(id)
		if IsValid(p) then
			p:RemoveDispatchBOL()
		end
	end)

	self:SetSyncVar(SYNC_DISPATCH_BOL, crime, true)

	local rf = RecipientFilter()
	rf:AddRecipientsByTeam(TEAM_CP)

	net.Start("impulseHL2RPSetBOL")
	net.WriteEntity(self)
	net.WriteUInt(crime, 8)
	net.Send(rf)
end

function meta:RemoveDispatchBOL()
	if not self:GetSyncVar(SYNC_DISPATCH_BOL, nil) then
		return
	end

	if timer.Exists("impulseHL2RPBOLExpire"..self:SteamID()) then
		timer.Remove("impulseHL2RPBOLExpire"..self:SteamID())
	end

	impulse.Dispatch.BOL[self:SteamID()] = nil

	self:SetSyncVar(SYNC_DISPATCH_BOL, nil, true)
end

function meta:ChangeDispatchBOLTime(time)
	if not self:IsDispatchBOL() then
		return
	end

	local id = self:SteamID()

	if timer.Exists("impulseHL2RPBOLExpire"..id) then
		timer.Adjust("impulseHL2RPBOLExpire"..id, time, 1, function()
			impulse.Dispatch.BOL[id] = nil

			local p = player.GetBySteamID(id)
			if IsValid(p) then
				p:RemoveDispatchBOL()
			end
		end)
	end
end

net.Receive("impulseHL2RPAddBOL", function(len, ply)
	if (ply.nextBOLCP or 0) > CurTime() then return end
	ply.nextBOLCP = CurTime() + 1

	if not ply:IsCP() or not ply:IsCPCommand() then
		return
	end

	if not IsValid(ply.CurTerminal) then
		return
	end

	local targ = net.ReadEntity()
	local crime = net.ReadUInt(8)


	if not IsValid(targ) or not targ:IsPlayer() or targ:IsDispatchBOL() or (targ == ply) then
		return
	end

	if not impulse.Config.ArrestCharges[crime] then
		return
	end

	targ:AddDispatchBOL(crime, impulse.Config.DefaultBOLTime)
	ply:Notify("You have added "..targ:Name().." to the BOL index.")
end)

net.Receive("impulseHL2RPRemoveBOL", function(len, ply)
	if (ply.nextBOLCP or 0) > CurTime() then return end
	ply.nextBOLCP = CurTime() + 1

	if not ply:IsCP() or not ply:IsCPCommand() then
		return
	end

	if not IsValid(ply.CurTerminal) then
		return
	end

	local targ = net.ReadEntity()

	if not IsValid(targ) or not targ:IsPlayer() or targ:IsCP() then
		return
	end

	if not targ:IsDispatchBOL() then
		return
	end

	targ:RemoveDispatchBOL()
	ply:Notify("You have removed "..targ:Name().." from the BOL index.")
end)