FROM python:3.9-slim-buster
WORKDIR /app
COPY . /app
RUN python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 3000
CMD python ./app.py