agility_boost = agility_boost or class({})

function agility_boost:GetTexture() return "agility_boost" end -- get the icon from a different ability

function agility_boost:IsPermanent() return true end
function agility_boost:RemoveOnDeath() return false end
function agility_boost:IsHidden() return self:GetStackCount() == 0 end 	-- we can hide the modifier
function agility_boost:IsDebuff() return (self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100) < 0 end 	-- make it red or green

function agility_boost:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function agility_boost:OnTooltip()
	return self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100
end

function agility_boost:GetModifierBonusStats_Agility()
	if IsClient() or self.lock then return end

	self.lock = true
	local attribute = self:GetParent():GetAgility()
	self.lock = false

	return (self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100)/100 * attribute
end
