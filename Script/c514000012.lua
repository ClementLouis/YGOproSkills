-- Chain Reaction
-- Can be used each time you activate a Trap card. Decreases your opponent's Life Points by 200.
function c514000012.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000012.aco)
	e1:SetOperation(c514000012.aop)
	c:RegisterEffect(e1)
end
function c514000012.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000012.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000002)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetOperation(c514000012.damop)
	Duel.RegisterEffect(e1,tp)
	
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c514000012.damop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetActiveType()==TYPE_TRAP and rp==tp and Duel.SelectYesNo(tp,aux.Stringid(514000012,0))then
		Duel.Hint(HINT_CARD,0,514000012)
		local lp=Duel.GetLP(tp)-200
		Duel.SetLP(1-tp,lp)
	end
end
