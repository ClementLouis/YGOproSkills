-- Draw Sense: Low Level
-- Can be used each time your Life Points decrease by 1800. In the Draw Phase, istead of doing a normal draw, draw a level 1-4 monster card.
function c514000037.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c514000037.aco)
	e1:SetOperation(c514000037.aop)
	c:RegisterEffect(e1)
	if not c514000037.global_check then
		c514000037.global_check=true
		c514000037[0]=nil
		c514000037[1]=nil
		c514000037[2]=0
		c514000037[3]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(c514000037.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c514000037.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()==1
end
function c514000037.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,514000026)
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
		Duel.Win(1-tp,0x55)
	end
	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCondition(c514000037.condition)
	e1:SetOperation(c514000037.operation)
	Duel.RegisterEffect(e1,tp)
	
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c514000037.checkop(e,tp,eg,ep,ev,re,r,rp)
	-- Debug.Message("checkop" .. tp)
    -- Debug.Message("c514000037[tp]:" .. tostring(c514000037[tp]))
    -- Debug.Message("c514000037[2+tp]:" .. tostring(c514000037[2+tp]))
    -- Debug.Message("lp=" .. Duel.GetLP(tp))
    if not c514000037[tp] then c514000037[tp]=Duel.GetLP(tp) end
    if c514000037[tp]>Duel.GetLP(tp) then
        c514000037[2+tp]=c514000037[2+tp]+(c514000037[tp]-Duel.GetLP(tp))
        c514000037[tp]=Duel.GetLP(tp)
    end
end

function c514000037.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 
	and c514000037[2+tp]>=1800 and Duel.GetDrawCount(tp)>0
end
function c514000037.filter(c)
	return c:IsLevelBelow(4) and c:IsAbleToHand()
end
function c514000037.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SelectYesNo(tp,aux.Stringid(514000026,0)) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetValue(0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1)
		Duel.RegisterEffect(e1,tp)
		local g=Duel.GetMatchingGroup(c40044918.filter,tp,LOCATION_DECK,0,nil)
		local sg=g:RandomSelect(tp,1)
		if g:GetCount()~=0 then
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
		end
		c514000037[2+tp]=0
	end
end