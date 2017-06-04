-- Mind Scan
-- If your Life Points are 3000 or more, you can see the cards Set in your opponent's field.
function c514000041.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000041.aco)
	e1:SetOperation(c514000041.aop)
	c:RegisterEffect(e1)
end
function c514000041.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000041.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000001)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCondition(c514000041.condition)
	e2:SetOperation(c514000041.operation)
	Duel.RegisterEffect(e2,tp)
	
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c514000041.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>=3000
end
function c514000041.cffilter(c)
	return c:IsFacedown() and c:GetFlagEffect(514000041)==0
end
function c514000041.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c514000041.cffilter,tp,0,LOCATION_ONFIELD,nil)
	
	if g:GetCount()>0 then
	local tc=g:GetFirst()
		while tc do
			Duel.ConfirmCards(tp,g1)
			tc:GetFirst():RegisterFlagEffect(514000041,RESET_EVENT+0x1fe0000,0,1)
			tc=g:GetNext()
		end
		
	end
end