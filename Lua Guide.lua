AddCSLuaFile()


--Code to be run specifically on SERVER
if SERVER then

end


--Code to be run specifically on CLIENT
if CLIENT then

end

-- Everything outside of these two if statements are considered 'shared'


-- Comments:
--[[

-- = Single line

--[[ 
Multi-line comment.
]]


--[[ Local and Global variables ]]
local myVariable = 5 -- Holding a number
myVariable = 10 -- Can be re-used to replace value
myVariable = "Hi!" -- Type does not need to be defined

nil -- "Lack of value" constant, often used instead of zero

"Test" -- Basic string.byte
'It\'s a wash!' -- Also a string, but needs an escape character "\" to allow for some forms of text


-- Numbers and exponents
15
0.56
8.3e10
8.3e+10
8.3e-10


-- Booleans
true 
false


--[[ Functions ]]--

-- A global function

function YellMessage( message )
	local loudMessage = string.upper( message ) .. "!"
	print( loudMessage )
end

-- A local function

local function AddNumbers( a, b)
	return a+Basic
end

-- Functions are a data type like any other (similar to objects)
-- Thus, if a function is small enough, or its operation is simple enough, it can be defined in a variable
-- This is called anonymous function expressions, allowing them to be created and instanced in tighter code

local SubtractNumbers = function( a,b )
	return a - b
end

--[[ Table ]]--

local myTable = {} --Empty table

myTable = {
	100, --Index in Lua starts at 1, not 0!
	5,
	200,
}


--[["Wait, isn't this an array?"
Nope! Lua tables are general-purpose key-value maps. 
They can hold everything and mix types, despite it not being conventional. 
]]

myTable2 = {
	[1] = "first",
	["fruit"] = "banana",
	[0] = "zero", --You can do this but it's just not conventional.	
}

--Lua still assumes a table starts at 1, so putting zero doesn't change anything.
--Most functions will skip over keys - as they're designed to stop or ignore nil values. 

--... Which means that you can make these even more egregious...

ohGodWhat = {
	["My Key"] = "My Value!", --String key and string value
	[2] = true, --Number key and boolean value
	[false] = function()   --Boolean key and function value??
		print( "What is this even" )
	end,
	[function()    --A function key and boolean value (whose idea is this????)
		print( "What in the")
	end] = true
}

--So what can be put into a table..?

h = {}

h["string"] = "ok"  						-- Strings
h[true] = "sure"							-- Boolean
h[420] = "the norm at this point"			-- Numbers
h[function() end] = "you really shouldn't"	-- Functions
h[{}] = "god has left us"					-- Another table
h[print] = "im not even mad, just sad"		-- A Function... loopback???

-- And the values can be changed or removed at any time, just call the key

ohGodWhat["My Key"] = "Another value"


--[[Conditional Flow Control]]

--if/elseif/else statements

local age = 18
if age < 18 then
	print("You're too young!\n")
elseif age == 20 then
	print("You're 20!\n")
else
	print("You're old!\n")
end

--[[Conditions used for flow:
== Equal to
~= Not Equal to
!= Not Equal to
< Less than
> Greater than
<= Less than or equal to
>= Greater than or equal to


--[[Coroutines vs Threads with Hooks]]

--[[
New vocab!

Thread: A single flow of instructions
Essentially one train track. 
Flows through a list of commands one at a time, without multitasking.

Multi-Threaded: Multiple threads running at once.
Essentially multiple tracks, multiple trains.
All trains are moving at the same time.
They can move in parallel, if the hardware allows.

Coroutine: Cooperative thread architecture
Eseentially, they're threads that can pause and resume whenever desired.
They're essentially psuedo-multithreading. 
Good for lightweight tasks that doesn't need full threading.
In other words, "stopping mid-sentence, going to go do something else, then returning to finish it."

Hook: A callback that triggers when something specific happens. 
Essentially a tripwire that fires when something specific happens in real time.
They differ from normal flow structure, as conditions/loops run sequentially. 
Hooks run off a live monitor. ]]


--Coroutines

co = coroutnie.create( function()  --Creates the coroutine, which takes a function as its argument.
	for i=1, 10 do
		print("co", i)
		coroutine.yield()		   --Yield pauses their execution and allows them to be resumed later.
	end
end)

--This block will now iterate through the loop, but after an iteration is done, it will pause.

--Reusming the coroutine will contuine stepping through it.

coroutine.resume(co) --> Will print "co 1"
coroutine.resume(co) --> Will print "co 2"
coroutine.resume(co) --> Will print "co 3"

--Once a coroutine has completed its code block, it is considered 'dead'. 
--corountine.status() will print the current status of a coroutine. 

print( corountine.status(co) ) --> Will print 'suspended' if paused, or 'dead' if complete.

--Corountines by default start in the suspended state on creation.




--Events and Hooks

--[[
Events are specific happenings in the game world. 
Common ones are when a player dies, spawns, takes damage, or disconnects.
There are also some events for non-game world things, such as HUD elements.
Events also carry data, such as "who died" and by what. 

GMod will tell the Lua what happened, and the Lua responds to such events by running Hooks. 

A Hook is a way to make a function run whenever something happens in game. 
There's already a list of baseline game-related hooks in GMod to view.
 
The main thing about a hook is that it's always available.
If statements will not be available once it's been executed.
]]

if player:IsOnFire() then 
	print("Stop, drop, and roll!")
end

-- This does one manual check. Once it's checked, it's done.
-- Hooks have a 3 part system. Create, Add, Run. 

--Step 1: Run

hook.Run("FireEvent") --We don't 'create' hooks, we just call them at any time, and they exists.

-- Step 2: Add (Or Listen)

hook.Add("FireEvent", "ListenerName_UniqueID", function(arg1, arg2)
	print("Fire Event activated!")
end)

--[[
This creates a listener, by providing:
- The event name 
- A unique listener ID (you make it up)
- Function that runs when hook is called
]]


-- Step 3: Run (Or Trigger)

hook.Run("FireEvent", player, true)

-- This will run all hooked functions as soon as it happens. 
-- Parameters passed will go to the function like arguments. 


-- Bonus Step: Remove

hook.Remove("FireEvent", "ListenerName_UniqueID")

-- This will remove the hook. Good for fixing things after rounds are over. 