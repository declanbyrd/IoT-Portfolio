fileList = file.list()
print(type(fileList))

for name, size in pairs(fileList) do
  print("File name: " .. name .. " with size of " .. size .. " bytes")
end

fileObjWrite = file.open("samplefile.txt", "w")
fileObjWrite:writeline("IoT First String")
fileObjWrite:write("second string")
fileObjWrite:write("third string")
print(fileObjWrite.readline())
fileObjWrite:close()

fileObjRead = file.open("samplefile.txt", "r")
fileObjRead:writeline("IoT First String")
fileObjRead:write("second string")
fileObjRead:write("third string")
print(fileObjRead.readline())
fileObjRead:close()

fileObjRead = file.open("samplefile.txt", "r")
print(fileObjRead.read())
print(fileObjRead.read())
fileObjRead:close()
fileObjRead = file.open("samplefile.txt", "r")
print(fileObjRead.read())
fileObjRead:close()

fileObjRead = file.open("samplefile.txt", "r")
print(fileObjRead.seek("cur", 11))
print(fileObjRead.read())
print(fileObjRead.seek("cur", -5))
print(fileObjRead.read())
