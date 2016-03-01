local block = require('radio.core.block')
local types = require('radio.types')

local SlicerBlock = block.factory("SlicerBlock")

function SlicerBlock:instantiate(threshold)
    self.threshold = threshold or 0.0

    self:add_type_signature({block.Input("in", types.Float32Type)}, {block.Output("out", types.BitType)})
end

function SlicerBlock:process(x)
    local out = types.BitType.vector(x.length)

    for i = 0, x.length-1 do
        out.data[i].value = (x.data[i].value > self.threshold) and 1 or 0
    end

    return out
end

return {SlicerBlock = SlicerBlock}
