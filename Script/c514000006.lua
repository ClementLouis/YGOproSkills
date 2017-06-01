-- Peak Performance
-- Begins Duel with the Field Spell "Mountain" activated.
function c514000006.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000006.aco)
	e1:SetOperation(c514000006.aop)
	c:RegisterEffect(e1)
end
function c514000006.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000006.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000006)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	local token=Duel.CreateToken(tp,50913601,nil,nil,nil,nil,nil,nil)		
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	e1:SetValue(TYPE_SPELL+TYPE_FIELD)
	token:RegisterEffect(e1)
	Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end

