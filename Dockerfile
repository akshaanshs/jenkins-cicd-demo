# Use official Python image as base
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy requirements file first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt --quiet

# Copy all project files
COPY . .

# Run the application
CMD ["python", "app.py"]