import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

file = 'pieces_16x16'

df = pd.read_csv(f'score/scoreEvolution_{file}.csv')
plt.xlabel("Crossovers")
plt.ylabel("Best score")
plt.title("Score evolution of each generation")
plt.grid(True)
sns.lineplot(data=df)
plt.get_current_fig_manager().full_screen_toggle()
plt.tight_layout()
plt.savefig(f'graphs/score_evolution_{file}.png', dpi=1080)
plt.close()
