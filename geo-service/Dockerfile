FROM python:3-alphine3.17
WORKDIR /app
COPY ./app
RUN pip install -r requirements.txt
EXPOSE 5000
CMD python ./app.py