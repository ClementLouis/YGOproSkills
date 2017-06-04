-- Prescience	
-- You can view the top card of both players' Decks until the end of the 5th turn.
function c514000043.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000043.aco)
	e1:SetOperation(c514000043.aop)
	c:RegisterEffect(e1)
end
function c514000043.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000043.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000043)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetCondition(c514000026.condition)
	e2:SetOperation(c514000043.operation)
	Duel.RegisterEffect(e2,tp)
	
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c514000041.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()<=5
end

function c514000043.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(e:GetHandler():GetControler(),1)
	local g2=Duel.GetDecktopGroup(1-e:GetHandler():GetControler(),1)
	Debug.Message(g:GetFirst():GetCode())
	Debug.Message(g:GetFirst():GetFlagEffect(514000043)==0)
	if g:GetFirst():GetFlagEffect(514000043)==0 then
		Duel.ConfirmDecktop(e:GetHandler():GetControler(),1)
		g:GetFirst():RegisterFlagEffect(514000043,RESET_EVENT+0x1fe0000,0,1)
	end
	if g2:GetFirst():GetFlagEffect(514000043)==0 then
		Duel.ConfirmDecktop(1-e:GetHandler():GetControler(),1)
		g2:GetFirst():RegisterFlagEffect(514000043,RESET_EVENT+0x1fe0000,0,1)
	end
end