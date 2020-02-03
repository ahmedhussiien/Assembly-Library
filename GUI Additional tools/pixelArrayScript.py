from PIL import Image

#Reading image data
im = Image.open(r"F:\MicroBonus\GameUI.bmp", 'r')
width, height = im.size
PixelValues = list(im.getdata())

#Dividing the data
result = ""
step = 30

for i in range(step, len(PixelValues), step):
    result = result +"db " + ", ".join(map(str,PixelValues[i-step:i])) + "\n"

#Print the result
print("w dw " + str(width))
print("h dw " + str(height))
print(result)