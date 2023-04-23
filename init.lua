--- === DocsGenerator ===
---
--- A menubar applet to generate Spoon docs
---

local obj = {}
setmetatable(obj, obj)


-- Metadata
obj.name = "DocsGenerator"
obj.version = "0.0.8"
obj.author = "Neta Elad <elad.neta@gmail.com>"
obj.homepage = "https://github.com/netaelad/DocsGenerator.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Local
local function openPicker()
    local spoons = hs.dialog.chooseFileOrFolder(
        "Choose Spoon directory", 
        os.getenv("HOME") .. "/.hammerspoon/Spoons"
    )
    if not spoons then
        return
    end
    for _, directory in pairs(spoons) do
        io.open(directory .. "/docs.json", "w"):write(hs.doc.builder.genJSON(directory)):close()
    end
end

-- Public
function obj:init()
    self.menubar = hs.menubar.new()

    self.menubar:setIcon(hs.image.imageFromName("NSAdvanced"):setSize({w=16,h=16}))
    self.menubar:setClickCallback(openPicker)
    self.menubar:setTooltip("Generate docs for Spoon")

    return self
end

return obj