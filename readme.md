# dockerized jupyter-notebook for machine-learning

as local `Python/conda` env can interfere with `jupyter` env, this uses containerized env instead.

this repo has been created to be used for machine-learning study.

로컬 컴퓨터의 파이썬/아나콘다 환경이 주피터 노트북의 파이썬/아나콘다 환경과 겹쳐서 오동작을 일으키는
경우가 있기 때문에 도커 내부의 컨테이너 환경을 이용합니다.

이 저장소는 🧠머신러닝 학습용으로 만들었습니다.

```sh
# boot up
docker-compose up

# flush container from memory
docker-compose down


# boot up jupyter lab
docker-compose -f jupyterlab.docker-compose.yaml up

# flusher jupyter lab container from memory
docker-compose -f jupyterlab.docker-compose down
```