# intro to machine learning
# SETUP
```sh
# conda virtual environment setup
# conda environment is irrelevant to individual directory
conda create -n $ENV_NAME

# conda virtual environment activation & deactivation
conda activate $ENV_NAME
conda deactivate

# other necessary libs
conda install jupyter notebook nb_conda
conda install -c conda-forge jupyter_contrib_nbextensions jupyter_nbextensions_configurator autopep8
pip3 install pandas numpy seaborn sklearn
```
