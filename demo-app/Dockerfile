# Use an official Python runtime as a parent image
FROM python:3.11.3-slim-buster

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DATABASE_NAME='db.sqlite3'
ENV DJANGO_SECRET_KEY='django-insecure-#x^_@z1'
ENV ENVIRONMENT='development'
ENV DEBUG='True'

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install Gunicorn
RUN pip install gunicorn


# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run the command to start Gunicorn or Django development server based on the environment
CMD python manage.py migrate; if [ "$ENVIRONMENT" = "production" ] ; then gunicorn demo.wsgi:application --bind 0.0.0.0:8000 ; else python manage.py runserver 0.0.0.0:8000 ; fi