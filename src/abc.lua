paths.dofile('util.lua')

-- variable
print('var')
a = 1
b = 'b'
local c = 'b'
print('')

-- table (array)
print('table')
ary = {1, 2.0, 'a', "cat"}
print("#ary", #ary)
print("type(ary)", type(ary))
for i, val in ipairs(ary) do
    print(i, val, type(val))
end
print('')

-- iteration
print('iter')
for i = 0,5,2 -- start, final, step
do
    print(i)
end
print('')

-- check file
print('check file')
dir = 'src'
print(dir, tostring(paths.dirp(dir)))
file = 'src/abc.lua'
print(file, tostring(paths.filep(file)))
file = 'src/abcd.lua'
print(file, tostring(paths.filep(file)))
print('')

-- write file
print('write file')
file = 'dummy.txt'
print('write ' .. file)
f = io.open(file, 'w')
f:write('hello\n')
f:write('world\n')
f:close()
print('')

-- read file
print('read file')
file = 'dummy.txt'
print('read ' .. file)
f = io.open(file, 'r')
--line = f:read()
--print(line)
data = f:read('*all')
print(data)
f:close()
print('')

-- struct.pack
print('struct.pack')
struct = require 'struct'
packed = struct.pack('<LIhBsbfd', 123456789123456789, 123456789, -3200, 255, 'Test message', -1, 1.56789, 1.56789)
L, I, h, B, s, b, f, d = struct.unpack('<LIhBsbfd', packed)
print(L, I, h, B, s, b, f, d)
print('')

-- torch.ByteTensor, struct.pack, write file
print('torch.ByteTensor, struct.pack, write file')
t = torch.ByteTensor(3,4)
print(t)
file = 'dummy.bin'
print('write ' .. file)
saveByteTensor(file, t)
print('')

-- read file, struct.unpack, torch.ByteTensor
file = 'dummy.bin'
print('read ' .. file)
t = loadByteTensor(file)
print(t)
print('')

-- image
image = require('image')

