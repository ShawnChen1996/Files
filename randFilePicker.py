import os
import random

class pathFlattener():
    def __init__(self, path='.'):
        self.path = path
        self.files = self.flatten()

    def flatten(self):
        files = []
        for f in os.walk(self.path):
            files.extend([os.path.join(f[0], x) for x in f[2]])
        return files


class randomFilePicker(pathFlattener):
    def __init__(self, path='.'):
        super().__init__(path)

    def pick(self, num=1):
        self.picked = random.sample(self.files, num)
        return self.picked

    def rmPicked(self):
        for f in self.picked:
            os.remove(f)
    
    def hidePicked(self):
        for f in self.picked:
            newname = os.path.join(os.path.dirname(f), '.' + os.path.basename(f))
            os.rename(f, newname)




c = randomFilePicker('test')
print(c.files)
c.pick()
c.picked
c.hidePicked()

