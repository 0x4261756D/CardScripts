--Star Battle Knight Cheron
local s,id=GetID()
function s.initial_effect(c)
	--Give Piercing
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(s.cost)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),0,LOCATION_MZONE)>=1
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_MZONE,0,1,nil)  end
end
function s.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(5) and c:IsRace(RACE_FIEND)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	--Requirement
	if Duel.DiscardDeck(tp,1,REASON_COST)==1 then
		--Effect
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_MZONE,0,1,1,nil)
		if #g>0 then
			Duel.HintSelection(g)
			local tc=g:GetFirst()
			--Piercing
			local e2=Effect.CreateEffect(c)
			e2:SetDescription(3208)
			e2:SetProperty(EFFECT_FLAG_CLIENT_HINT)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_PIERCE)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffectRush(e2)
		end
	end
end