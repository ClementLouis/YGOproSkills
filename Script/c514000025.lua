-- Titan Showdown
-- Whichever player has doulbe or more LP than the other takes double battle damage.
function c514000025.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000025.aco)
	e1:SetOperation(c514000025.aop)
	c:RegisterEffect(e1)
end
function c514000025.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000025.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000025)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EFFECT_CHANGE_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,0)
	e4:SetCondition(c514000025.condition1)
	e4:SetValue(c514000025.val)
	Duel.RegisterEffect(e4,tp)
	
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCode(EFFECT_CHANGE_DAMAGE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(0,1)
	e5:SetCondition(c514000025.condition2)
	e5:SetValue(c514000025.val)
	Duel.RegisterEffect(e4,tp)
	
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c514000025.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>(Duel.GetLP(1-tp)*2)
end
function c514000025.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<(Duel.GetLP(1-tp)*2)
end
function c514000025.val(e,re,dam,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 or bit.band(r,REASON_EFFECT)~=0 then return dam*2
	else return dam end
end
