-- Cheater's Coin
-- If your Life Points are at least 1000 more than opponent's, and if you have at least 5 cards in your hand, your coin tosses always land on heads.
function c514000016.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000016.aco)
	e1:SetOperation(c514000016.aop)
	c:RegisterEffect(e1)
	local f=Duel.TossCoin
	Duel.TossCoin=function(tp,ct)
		if Duel.IsPlayerAffectedByEffect(tp,514000016) then
			local tct=ct
			local t={}
			for i=1,ct do
				local res=1
				table.insert(t,res)
			end
			return table.unpack(t)
		else
			return f(tp,ct)
		end
	end
end
function c514000016.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000016.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000016)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end

	
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(514000016)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(1,0)
	e6:SetCondition(c514000016.condition)
	Duel.RegisterEffect(e6,tp)
	
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c514000016.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetLP(c:GetControler())-Duel.GetLP(1-c:GetControler()))>=1000 and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=5
end
