-- Grandpa's cards
-- Begin duel with the 5 exodia pieces in your Deck.
function c514000011.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000011.aco)
	e1:SetOperation(c514000011.aop)
	c:RegisterEffect(e1)
end
function c514000011.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000011.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000011)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	local token1=Duel.CreateToken(tp,33396948,nil,nil,nil,nil,nil,nil)		
	local token2=Duel.CreateToken(tp,7902349,nil,nil,nil,nil,nil,nil)		
	local token3=Duel.CreateToken(tp,70903634,nil,nil,nil,nil,nil,nil)		
	local token4=Duel.CreateToken(tp,44519536,nil,nil,nil,nil,nil,nil)		
	local token5=Duel.CreateToken(tp,8124921,nil,nil,nil,nil,nil,nil)
	Duel.SendtoDeck(token1,nil,2,REASON_RULE)
	Duel.SendtoDeck(token2,nil,2,REASON_RULE)
	Duel.SendtoDeck(token3,nil,2,REASON_RULE)
	Duel.SendtoDeck(token4,nil,2,REASON_RULE)
	Duel.SendtoDeck(token5,nil,2,REASON_RULE)
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end

