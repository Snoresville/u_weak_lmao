intelligence_boost = intelligence_boost or class({})

function intelligence_boost:GetTexture() return "intelligence_boost" end -- get the icon from a different ability

function intelligence_boost:IsPermanent() return true end
function intelligence_boost:RemoveOnDeath() return false end
function intelligence_boost:IsHidden() return self:GetStackCount() == 0 end 	-- we can hide the modifier
function intelligence_boost:IsDebuff() return (self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100) < 0 end 	-- make it red or green

function intelligence_boost:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end

function intelligence_boost:OnTooltip()
	return self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100
end

function intelligence_boost:GetModifierBonusStats_Intellect()
	if IsClient() or self.lock then return end

	self.lock = true
	local attribute = self:GetParent():GetIntellect()
	self.lock = false

	return (self:GetParent():GetHealthPercent() * (self:GetStackCount() + 1) - 100)/100 * attribute
end
