--ラスト・リゾート
--Last Resort
local s,id=GetID()
function s.initial_effect(c)
	--Activate 1 "Ancient City - Rainbow Ruins" from the Deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
s.listed_names={34487429} --Ancient City - Rainbow Ruins
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function s.filter(c,tp)
	return c:IsCode(34487429) and c:GetActivateEffect():IsActivatable(tp,true,true)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,tp) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	local fc=Duel.GetFieldCard(1-tp,LOCATION_FZONE,0)
	local canadd = fc and fc:IsFaceup() and Duel.IsPlayerCanDraw(1-tp,1)
	Duel.ActivateFieldSpell(tc,e,tp,eg,ep,ev,re,r,rp)
	if canadd and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end