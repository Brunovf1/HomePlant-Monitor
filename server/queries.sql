SELECT
  time_bucket('1 hour', timestamp) AS bucket,
  AVG(temperature) AS avg_temperature,
  AVG(humidity) AS avg_humidity,
  AVG(pressure) AS avg_pressure
FROM sensor_readings
GROUP BY bucket
ORDER BY bucket;

SELECT
  sensor_id,
  time_bucket('1 hour', timestamp) AS bucket,
  AVG(temperature) AS avg_temperature,
  AVG(humidity) AS avg_humidity
FROM sensor_readings
GROUP BY sensor_id, bucket
ORDER BY bucket;

SELECT DISTINCT ON (sensor_id)
  sensor_id,
  timestamp,
  temperature,
  humidity,
  pressure
FROM sensor_readings
ORDER BY sensor_id, timestamp DESC;

SELECT
  time_bucket('1 minute', timestamp) AS bucket,
  COUNT(*) AS readings_count
FROM sensor_readings
GROUP BY bucket
ORDER BY bucket;
