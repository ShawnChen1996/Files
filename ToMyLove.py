

print("Hello 小青青!")
s = "ShawnLovesYouSooooMuch"
print('\n'.join([''.join([(s[(x-y)%len(s)]if((x*0.05)**2+(y*0.1)**2-1)**3-(x*0.05)**2*(y*0.1)**3<=0 else' ')for x in range(-30,30)])for y in range(15,-15,-1)]))

print('爱你的形状送给你')
