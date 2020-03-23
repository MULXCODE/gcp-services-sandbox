FROM gcr.io/google-appengine/nodejs

# Copy application code.
COPY . /app/
COPY .env /app/.env

WORKDIR /app
RUN /bin/bash -c "source .env"

# Install dependencies.
RUN npm --unsafe-perm install