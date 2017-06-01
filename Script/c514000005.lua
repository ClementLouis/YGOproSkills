-- Elements Unite!
-- You will start the duel with 500 Life Points
 -- and your starting hand will be 1 card, which is "Gate Guardian". 
 -- In addition, you will start the Duel with Suijin, Kazejin, and Sanga of the Thunder on the side of your field.
 -- Their effects are negated and they cannot attack as long as they are face-up on the field.
function c514000005.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000005.aco)
	e1:SetOperation(c514000005.aop)
	c:RegisterEffect(e1)
end
function c514000005.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000005.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000003)
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
	Duel.SetLP(tp,500)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,nil,2,REASON_RULE)
	local tokenGate=Duel.CreateToken(tp,25833572) 
	Duel.SendtoHand(tokenGate,nil,REASON_RULE)
	
	local g=Group.FromCards(Duel.CreateToken(tp,25955164),Duel.CreateToken(tp,98434877),Duel.CreateToken(tp,62340868))
	local tc=g:GetFirst()
	while tc do
	    if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		    local e1=Effect.CreateEffect(c)
		    e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		    tc:RegisterEffect(e1,true)
		    local e2=e1:Clone()
		    e2:SetCode(EFFECT_DISABLE)
		    tc:RegisterEffect(e2,true)
		    local e3=e1:Clone()
		    e3:SetCode(EFFECT_DISABLE_EFFECT)
		    tc:RegisterEffect(e3,true)
		end
	    tc=g:GetNext()
	end
	
	
	
end

