from player import Player
import numpy as np
import pandas as pd
import gower


p1 = Player(100, 1.0, 0.75, 1)
p2 = Player(750, 2.4, 1.33, 9)
p3 = Player(450, 3.0, 1.00, 7)
p4 = Player(750, 2.3, 2.00, 5)
p5 = Player(175, 1.7, 0.50, 5)
p6 = Player(350, 2.1, 0.75, 8)
p7 = Player(600, 3.2, 1.50, 3)
p8 = Player(650, 1.7, 2.25, 1)
p9 = Player(800, 4.0, 1.00, 1)

people = [p1, p2, p3, p4, p5, p6, p7, p8, p9]

df = pd.DataFrame([vars(p) for p in people])

dist_matrix = gower.gower_matrix(df)

print(dist_matrix)






