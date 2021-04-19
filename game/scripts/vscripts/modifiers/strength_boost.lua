strength_boost = strength_boost or class({})

function strength_boost:GetTexture() return "strength_boost" end -- get the icon from a different ability

function strength_boost:IsPermanent() return true end
function strength_boost:RemoveOnDeath() return false end
function strength_boost:IsHidden() return self:GetStackCount() == 0 end 	-- we can hide the modifier
function strength_boost:IsDebuff() return (self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100) < 0 end 	-- make it red or green

function strength_boost:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function strength_boost:OnTooltip()
	return self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100
end

function strength_boost:GetModifierBonusStats_Strength()
	if IsClient() or self.lock then return end

	self.lock = true
	local attribute = self:GetParent():GetStrength()
	self.lock = false

	return (self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100)/100 * attribute
end
