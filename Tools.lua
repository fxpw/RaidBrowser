


-- local function addapi(object)
-- 	local mt = getmetatable(object).__index
-- 	if not object.Size then mt.Size = Size end
-- 	-- if not object.Point then mt.Point = Point end
-- 	-- if not object.SetOutside then mt.SetOutside = SetOutside end
-- 	-- if not object.SetInside then mt.SetInside = SetInside end
-- 	-- if not object.SetTemplate then mt.SetTemplate = SetTemplate end
-- 	if not object.CreateBackdrop then mt.CreateBackdrop = CreateBackdrop end
-- 	-- if not object.CreateShadow then mt.CreateShadow = CreateShadow end
-- 	-- if not object.Kill then mt.Kill = Kill end
-- 	-- if not object.Width then mt.Width = Width end
-- 	-- if not object.Height then mt.Height = Height end
-- 	-- if not object.FontTemplate then mt.FontTemplate = FontTemplate end
-- 	-- if not object.StripTextures then mt.StripTextures = StripTextures end
-- 	-- if not object.StyleButton then mt.StyleButton = StyleButton end
-- 	-- if not object.CreateCloseButton then mt.CreateCloseButton = CreateCloseButton end
-- 	-- if not object.GetNamedChild then mt.GetNamedChild = GetNamedChild end
-- end



-- local handled = {["Frame"] = true}
-- local object = CreateFrame("Frame")
-- addapi(object)
-- addapi(object:CreateTexture())
-- addapi(object:CreateFontString())

-- object = EnumerateFrames()
-- while object do
-- 	if not handled[object:GetObjectType()] then
-- 		addapi(object)
-- 		handled[object:GetObjectType()] = true
-- 	end

-- 	object = EnumerateFrames(object)
-- end