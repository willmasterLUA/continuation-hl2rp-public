concommand.Add("impulse_ops_eventmanager", function(ply)
	if not ply:IsTrialGamemaster() then
		return
	end
--IsEventAdmin
	local c = table.Count(impulse.Ops.EventManager.Sequences)

	net.Start("impulseOpsEMMenu")
	net.WriteUInt(c, 8)

	for v,k in pairs(impulse.Ops.EventManager.Sequences) do
		net.WriteString(v)	
	end

	net.Send(ply)
end)