FROM continuumio/miniconda3:latest
RUN /opt/conda/bin/conda install jupyter notebook nb_conda seaborn -y --quiet
RUN yes | pip install graphviz sklearn pandas_profiling
RUN yes | pip install sqlalchemy pymysql
RUN /opt/conda/bin/conda install -c conda-forge jupyter_contrib_nbextensions jupyter_nbextensions_configurator autopep8
# installing mecab-ko
RUN wget -O /tmp/mecab-0.996-ko-0.9.2.tar.gz  https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz
RUN tar -zxvf /tmp/mecab-0.996-ko-0.9.2.tar.gz -C /tmp
RUN cd /tmp/mecab-0.996-ko-0.9.2
RUN ./configure
RUN make
RUN sudo make install
# installing mecab-ko-dic
RUN wget -O /tmp/mecab-ko-dic-2.1.1-20180720.tar.gz https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz
RUN tar -zxvf /tmp/mecab-ko-dic-2.1.1-20180720.tar.gz -C /tmp
RUN cd /tmp/mecab-ko-dic-2.1.1-20180720
RUN ./autogen.sh
RUN ./configure
RUN make
RUN sudo make install
RUN sudo ldconfig 
# ----
RUN mkdir /opt/notebooks
RUN touch /opt/nbconfig.json
EXPOSE 8888
# must use '0.0.0.0' instead of '*'
# https://stackoverflow.com/questions/52706238/jupyter-throwing-error-socket-gaierror-errno-2-name-or-service-not-known
CMD /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='0.0.0.0' --port=8888 --no-browser --allow-root