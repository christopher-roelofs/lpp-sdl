testString = "hello world my name is david"
emptyString = ""
for i = 1, #testString, 1 do
emptyString = emptyString .. string.sub(testString,1,1)
testString = string.sub(testString,2,#testString)
print(emptyString)
end
print(testString)

