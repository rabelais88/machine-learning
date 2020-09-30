FROM continuumio/miniconda3:latest
RUN /opt/conda/bin/conda install jupyter notebook nb_conda seaborn -y --quiet
RUN yes | pip install graphviz sklearn pandas_profiling
RUN /opt/conda/bin/conda install -c conda-forge jupyter_contrib_nbextensions jupyter_nbextensions_configurator autopep8
RUN mkdir /opt/notebooks
RUN touch /opt/nbconfig.json
EXPOSE 8888
# must use '0.0.0.0' instead of '*'
# https://stackoverflow.com/questions/52706238/jupyter-throwing-error-socket-gaierror-errno-2-name-or-service-not-known
CMD /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='0.0.0.0' --port=8888 --no-browser --allow-root