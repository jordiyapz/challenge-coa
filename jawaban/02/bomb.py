
# data
intro = 'Welcome to my litte bomb. You have 3 phases with which to blow yourself up. Have a nice day!\n -clapper'
phaseMsg = ['Phase 1 Complete. Cable 1 is defused!\n I think you are just lucky ...', 'Phase 2 Complete. Cable 2 is defused!\n So you can do some algebra heh...', 'Congratulation! You save the world!']
fail = 'BOOOM!! BOOOM! Ha ha ha You fail'
codex = 'ACDEGJMNRW1234567890'

# text
def boom():
    print (fail)

def getInput():
    str = raw_input('input: ')
    valid = True
    if (str == ""):
        valid = False
    return (str, valid)

def runPhase(phase):
    if phase == 1 :
        var1, valid = getInput()
        if not valid:
            return False
        return int(var1) == 370-256
    if phase == 2 :
        var1, valid = getInput()
        if not valid:
            return False
        t0 = int(var1)
        t1 = '600D'
        t2 = 'F00D'
        t3 = int(t1, 16) & 0
        t4 = int(t2, 16) | 0
        t5 = t0 + t3
        t6 = t0 - t4
        t7 = t5 * t6    
        return t7 == t0
    if phase == 3:
        print('This is last stage. Good luck, you really need it he he...')
        var1, valid = getInput()
        codec = [0,2,8,0,5,4,1,9,9,3,6,5,3,7,2]
        secretKey = ""
        for x in codec:
            secretKey = secretKey + codex[x]
        return var1 == secretKey
        
def main():
    print(intro)
    for n in range(3):
        if runPhase(n+1):
            print(phaseMsg[n])
        else:
            boom()
            return

main()

