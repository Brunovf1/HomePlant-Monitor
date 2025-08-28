-- Criar extensão TimescaleDB
CREATE EXTENSION IF NOT EXISTS timescaledb;

-- Criar tabela para leituras de sensores
CREATE TABLE sensor_readings (
    id BIGSERIAL,
    sensor_id TEXT NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    temperature DOUBLE PRECISION,
    humidity DOUBLE PRECISION,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Converter em hypertable (TimescaleDB)
SELECT create_hypertable('sensor_readings', 'timestamp');

-- Criar índices para acelerar queries
CREATE INDEX ON sensor_readings (sensor_id, timestamp DESC);

CREATE INDEX idx_sensor_readings_id ON sensor_readings (id);

-- Exemplo de compressão (opcional, para históricos grandes)
ALTER TABLE sensor_readings SET (
  timescaledb.compress,
  timescaledb.compress_orderby = 'timestamp DESC',
  timescaledb.compress_segmentby = 'sensor_id'
);

-- Criar política de compressão automática após 7 dias
SELECT add_compression_policy('sensor_readings', INTERVAL '7 days');

-- Criar política de retenção (opcional: excluir dados após 1 ano)
SELECT add_retention_policy('sensor_readings', INTERVAL '365 days');
