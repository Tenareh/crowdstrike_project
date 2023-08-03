# use the officail Phython base image
FROM python:3.9-slim

# set the working Directory
WORKDIR /app

# copy the requirements.txt file to the container
COPY requirements.txt

# install phython dependencies
RUN pip install -no-cache-dir-r requirements.txt

# copy the application code to container
COPY app.py

# Expose the port on which the flask application will run (change if needed)
EXPOSE 8080

# start the application
CMD ["python", "app.py"]
