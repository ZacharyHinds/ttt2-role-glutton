local base = "pure_skin_element"

DEFINE_BASECLASS(base)

HUDELEMENT.Base = base

if CLIENT then -- CLIENT
	local pad = 7 -- padding
	local iconSize = 64

	local const_defaults = {
		basepos = {x = 0, y = 0},
		size = {w = 365, h = 32},
		minsize = {w = 225, h = 32}
	}

	function HUDELEMENT:PreInitialize()
		BaseClass.PreInitialize(self)

		local hud = huds.GetStored("pure_skin")
		if not hud then return end

		hud:ForceElement(self.id)
	end

	function HUDELEMENT:Initialize()
		self.scale = 1.0
		self.basecolor = self:GetHUDBasecolor()
		self.pad = pad
		self.iconSize = iconSize

		BaseClass.Initialize(self)
	end

	-- parameter overwrites
	function HUDELEMENT:IsResizable()
		return true, false
	end
	-- parameter overwrites end

	function HUDELEMENT:GetDefaults()
		const_defaults["basepos"] = {
			x = 10 * self.scale,
			y = ScrH() - self.size.h - 146 * self.scale - self.pad - 10 * self.scale
		}

		return const_defaults
	end

	function HUDELEMENT:PerformLayout()
		self.scale = self:GetHUDScale()
		self.basecolor = self:GetHUDBasecolor()
		self.iconSize = iconSize * self.scale
		self.pad = pad * self.scale

		BaseClass.PerformLayout(self)
	end

	function HUDELEMENT:DrawComponent(multiplier, col, text)
		multiplier = multiplier or 1

		local pos = self:GetPos()
		local size = self:GetSize()
		local x, y = pos.x, pos.y
		local w, h = size.w, size.h

		self:DrawBg(x, y, w, h, self.basecolor)

		-- draw bar
		self:DrawBar(x + pad, y + pad, w - pad * 2, h - pad * 2, col, multiplier, scale, text)

		self:DrawLines(x, y, w, h, self.basecolor.a)
	end

	function HUDELEMENT:ShouldDraw()
		local client = LocalPlayer()

		return IsValid(client)
	end

	function HUDELEMENT:Draw()
		local client = LocalPlayer()
		local multiplier

		local color = GLUTTON.color
		if not color then return end

		if client:IsActive() and client:Alive() and client:GetSubRole() == ROLE_GLUTTON then
			if client:GetNWInt("Appetite", 0) > 0 then
				local hungerTime = client:GetNWInt("Hunger", 0)
				local appetite_state = client:GetNWInt("Appetite", 0)
				local delay = 1
				local appetite_name = "none"

				if appetite_state == 1 then
					delay = 30
					appetite_name = "Hungry"
				elseif appetite_state == 2 then
					delay = 20
					appetite_name = "Starving"
				elseif appetite_state == 3 then
					delay = 10
					appetite_name = "Insatiable"
				elseif appetite_state == 4 then
					delay = 1
					appetite_name = "Ravenous"
				end

				multiplier = hungerTime - CurTime()
				multiplier = multiplier / delay

				local secondColor = GLUTTON.bgcolor
				local r = color.r - (color.r - secondColor.r) * multiplier
				local g = color.g - (color.g - secondColor.g) * multiplier
				local b = color.b - (color.b - secondColor.b) * multiplier

				color = Color(r, g, b, 255)
			else
				multiplier = 0
			end
		end

		if HUDEditor.IsEditing then
			self:DrawComponent(1, color)
		elseif multiplier then
			self:DrawComponent(multiplier, color, client:GetNWInt("Appetite", 0) and appetite_name)
		end
	end
end
