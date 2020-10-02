FROM continuumio/miniconda3:latest
RUN /opt/conda/bin/conda install jupyter notebook nb_conda seaborn -y --quiet
RUN yes | pip install graphviz sklearn pandas_profiling
RUN yes | pip install sqlalchemy pymysql
RUN yes | pip install spacy natto-py
RUN python -m spacy download en
RUN rm -rf ~/.cache/pip
RUN /opt/conda/bin/conda install -c conda-forge jupyter_contrib_nbextensions jupyter_nbextensions_configurator autopep8
RUN DIR_BEFORE=$(pwd)
# to use C compiler in mecab-ko
RUN apt-get update
RUN apt install -y build-essential automake
# installing mecab-ko
# https://stackoverflow.com/questions/44451696/bin-sh-1-configure-not-found-dockerfile
RUN wget -O /tmp/mecab-0.996-ko-0.9.2.tar.gz  https://bitbucket.org/eunjeon/mecab-ko/downloads/mecab-0.996-ko-0.9.2.tar.gz \
  && tar -zxvf /tmp/mecab-0.996-ko-0.9.2.tar.gz -C /tmp \
  && cd /tmp/mecab-0.996-ko-0.9.2 \
  && ./configure \
  && make \
  && make install \ 
  && ldconfig
# installing mecab-ko-dic
RUN wget -O /tmp/mecab-ko-dic-2.1.1-20180720.tar.gz https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz \
  && tar -zxvf /tmp/mecab-ko-dic-2.1.1-20180720.tar.gz -C /tmp \
  && cd /tmp/mecab-ko-dic-2.1.1-20180720 \
  && ./autogen.sh \
  && ./configure \
  && make \
  && make install \
  && ldconfig
# finish installing mecab-ko
RUN rm -rf /tmp/mecab*
RUN apt-get clean
RUN cd $DIR_BEFORE
RUN mkdir /opt/notebooks
RUN touch /opt/nbconfig.json
EXPOSE 8888
# must use '0.0.0.0' instead of '*'
# https://stackoverflow.com/questions/52706238/jupyter-throwing-error-socket-gaierror-errno-2-name-or-service-not-known
CMD /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='0.0.0.0' --port=8888 --no-browser --allow-root