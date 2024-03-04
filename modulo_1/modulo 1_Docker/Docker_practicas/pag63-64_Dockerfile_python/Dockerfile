FROM python:3.5
RUN apt-get update
RUN pip install Flask
ADD . /opt/webapp/
WORKDIR /opt/webapp
ENV FLASK_APP=hello.py
EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]
