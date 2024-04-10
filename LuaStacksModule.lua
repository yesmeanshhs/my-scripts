-- Stack principle in Roblox Lua (Exploits)
-- This follows a basic of best performance wise way of creating undo redo system
-- With this, you can load this github and start making it act like a module script

local Stacks = {}
Stacks.__index = Stacks
Stacks.ConvertToString = function(self)
if self.StackData then
local Strings = {}
for _, v in ipairs(self.StackData) do
table.insert(Strings,tostring(v))
end
return "{"..table.concat(Strings,", ").."}"
end
end

function Stacks.New()
return setmetatable({StackData = {},StackAmount = 0},Stacks)
end

function Stacks:Push(...)
local RetrievedArgument = select("#",...)
if RetrievedArgument == 0 then
error("A Stacks Function tried to push with an empty argument! (Error_ArgumentParam_nil)")
end
for IndexLoop = 1, RetrievedArgument do
local ValueTuple = select(IndexLoop,...)
self.StackAmount += 1
self.StackData[self.StackAmount] = ValueTuple
end
end

function Stacks:Pop()
if self.StackAmount == 0 then
return nil
end
if self.StackData[self.StackAmount] then
local ItemStackData = self.StackData[self.StackAmount]
self.StackData[self.StackAmount] = nil
self.StackAmount -= 1
return ItemStackData
end
return nil
end

function Stacks:Peek()
if self.StackAmount == 0 then
return nil
end
if self.StackData[self.StackAmount] then
return self.StackData[self.StackAmount]
end
return nil
end

function Stacks:Clear()
self.StackData = {}
self.StackAmount = 0
end

function Stacks:Empty()
return self.StackAmount == 0
end

function Stacks:Size()
return self.StackAmount
end

-- This will be providing a way of creating TAS in roblox

function Stacks:Iterator()
local Index = 0
if self.StackAmount == 0 then
return function() end
end
if Index > self.StackAmount then
return function() end
end
return function()
if Index < self.StackAmount then
local IndexValue = self.StackData[Index]
Index += 1
return IndexValue
end
end
end

function Stacks:ReverseIterator()
local Index = self.StackAmount
if Index == 0 then
return function() end
end
return function()
if Index > 0 then
local IndexValue = self.StackData[Index]
Index -= 1
return IndexValue
end
end
end

return Stacks
