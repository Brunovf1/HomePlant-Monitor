# 🌿 HomePlant Monitor

**Sistema de monitoramento IoT para plantas residenciais**

O **HomePlant Monitor** é um projeto de Internet das Coisas (IoT) projetado para monitorar a saúde das plantas em uma residência. Utilizando sensores conectados, displays de notificação e um servidor local, o sistema ajuda o usuário a manter suas plantas sempre bem cuidadas, notificando automaticamente quando o solo estiver seco.

---

## 📦 Componentes do Sistema

### 🛰️ Sensores (ESP8266)

Dispositivos compactos baseados em ESP8266 que são instalados diretamente nos vasos das plantas. Eles realizam a leitura dos seguintes dados:

- 🌡️ **Temperatura ambiente**
- 💧 **Umidade do solo**

**Características:**

- Alimentação via baixa voltagem (5V a 12V)
- Envio automático de dados ao servidor a cada **1 hora**
- Botão físico para envio imediato de leitura
- Comunicação via Wi-Fi com o servidor local

---

### 📺 Displays de Alerta

Dispositivos responsáveis por **exibir mensagens e acionar LEDs** quando o servidor detecta solo seco ou quando a umidade volta ao normal.

**Características:**

- Comunicação contínua com o servidor via rede local
- Tela integrada para mensagens de alerta
- LEDs indicadores de solo seco (aviso visual)

---

### 🖥️ Servidor Local

Responsável por centralizar os dados dos sensores e coordenar os displays.

**Características:**

- Executado via Docker
- Roda 100% na **intranet residencial** (sem necessidade de internet)
- Avalia os dados recebidos e compara com o limiar `LOW_HUMID`
- Gera **eventos de alerta** para os displays:
  - Quando a umidade do solo fica **abaixo do limite**
  - Quando a umidade volta ao **nível aceitável**
- Expõe uma API REST local (futuramente Web UI opcional)

---

## ⚙️ Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/homeplant-monitor.git
cd homeplant-monitor
```

### 2. Configurar variáveis de ambiente

Crie um arquivo `.env` com os seguintes parâmetros:

```env
LOW_HUMID=30      # Limiar de umidade mínima (%)
READ_INTERVAL=3600 # Intervalo entre leituras dos sensores (segundos)
```

### 3. Subir o servidor com Docker

```bash
docker compose up -d
```

# IoT Sensor Data Pipeline

Este projeto implementa um pipeline para coleta, armazenamento e visualização de dados de sensores usando **MQTT**, **TimescaleDB** e **Grafana**.

## Arquitetura

- **MQTT (Eclipse Mosquitto)** → Recebe dados dos sensores (ex: temperatura, umidade).
- **TimescaleDB** → Armazena os dados em formato de séries temporais (baseado no PostgreSQL).
- **Grafana** → Conecta-se ao banco de dados para visualização e dashboards.

## Estrutura dos Serviços

- `mosquitto`: Servidor MQTT para ingestão de dados.
- `timescaledb`: Banco de dados PostgreSQL com extensão TimescaleDB.
- `grafana`: Interface de visualização e análise.

## Como usar

### 1. Subir os serviços
```bash
docker-compose up -d
```

### 2. Inicializar banco de dados
Dentro do container do TimescaleDB, rode o script de schema:
```bash
docker exec -i timescaledb psql -U postgres -d sensors < schema.sql
```

### 3. Inserir dados de teste
```bash
docker exec -i timescaledb psql -U postgres -d sensors < inserts.sql
```

### 4. Consultar exemplo de agregação
```bash
docker exec -i timescaledb psql -U postgres -d sensors < queries.sql
```

### 5. Acessar Grafana
Abra [http://localhost:3000](http://localhost:3000)  
Usuário padrão: `admin`  
Senha: `admin` (ou definida via secret no docker-compose)

## Estrutura dos Arquivos

- `docker-compose.yml` → Orquestração dos serviços
- `schema.sql` → Criação de tabelas e hypertables
- `inserts.sql` → Inserts de teste
- `queries.sql` → Exemplos de queries de agregação
- `grafana_dashboard.json` → Dashboard pronto para importar

## Próximos Passos

- Criar serviço de consumidor MQTT para inserir no TimescaleDB
- Automatizar migrations do banco
- Integrar previsão ML/IA com dados históricos
