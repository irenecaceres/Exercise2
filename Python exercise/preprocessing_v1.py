import pandas as pd

df = pd.read_csv('datasets/tips.csv')

print(f'The sum of all tips is {df.tip.sum()}')


