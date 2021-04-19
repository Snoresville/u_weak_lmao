item_intelligence_boost = class({})

-- Ability Start
function item_intelligence_boost:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()

    if caster:IsHero() and caster:IsRealHero() and not caster:IsIllusion() then
        caster:FindModifierByName("intelligence_boost"):IncrementStackCount()
		EmitSoundOn("Item.TomeOfKnowledge", caster)

        -- Consume one charge
        self:SpendCharge()
    end
end