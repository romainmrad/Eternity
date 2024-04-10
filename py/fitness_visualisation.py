import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv(f'./solutionOutput/fitness.csv')
plt.xlabel("Runs")
plt.ylabel("Best fitness")
plt.title("GA runs fitness")
plt.grid(True)
sns.lineplot(data=df)
plt.get_current_fig_manager().full_screen_toggle()
plt.tight_layout()
plt.savefig(f'./graphs/fitness.png', dpi=1080)
plt.close()
