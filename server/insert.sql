-- Inserindo leituras simuladas para 2 sensores
INSERT INTO sensor_readings (sensor_id, timestamp, temperature, humidity)
VALUES
  ('sensor_A', now() - interval '10 minutes', 22.5, 55.2, 1012.3, 1.2),
  ('sensor_A', now() - interval '5 minutes', 23.0, 54.8, 1012.1, 1.3),
  ('sensor_A', now(), 23.2, 54.5, 1012.0, 1.4),

  ('sensor_B', now() - interval '10 minutes', 19.8, 61.0, 1011.8, 0.9),
  ('sensor_B', now() - interval '5 minutes', 20.0, 60.5, 1011.6, 1.0),
  ('sensor_B', now(), 20.1, 60.2, 1011.5, 1.1);
