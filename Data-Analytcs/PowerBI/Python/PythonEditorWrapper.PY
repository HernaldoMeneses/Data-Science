# Prolog - Auto Generated #
import os, uuid, matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot
import pandas

import sys
sys.tracebacklimit = 0

os.chdir(u'C:/Users/FRIOBOM54/PythonEditorWrapper_684a889f-bc5e-4f70-8407-481a07a38954')
dataset = pandas.read_csv('input_df_9c469a84-13f9-4c18-96e2-053cb3129d76.csv')

matplotlib.pyplot.figure(figsize=(5.55555555555556,4.16666666666667), dpi=72)
matplotlib.pyplot.show = lambda args=None,kw=None: matplotlib.pyplot.savefig(str(uuid.uuid1()))
# Original Script. Please update your script content here and once completed copy below section back to the original editing window #
# O código a seguir para criar um dataframe e remover as linhas duplicadas sempre é executado e age como um preâmbulo para o script: 

# dataset = pandas.DataFrame(Origin, Marca, % Meta, GAP)
# dataset = dataset.drop_duplicates()

# Cole ou digite aqui seu código de script:

MeasureWithPython = 
VAR result = 
    PYTHONSCRIPT(
        "import pandas as pd; return len(df)",
        SUMX('Vendas', 1)
    )
RETURN
    result


# Epilog - Auto Generated #
os.chdir(u'C:/Users/FRIOBOM54/PythonEditorWrapper_684a889f-bc5e-4f70-8407-481a07a38954')
