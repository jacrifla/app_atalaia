#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiUdp.h>
#include <NTPClient.h>
// #include <EEPROM.h>
#include <ArduinoJson.h>
#include <TimeLib.h>

#define RELAY_PIN 0
#define SENSOR_PIN 2

// Módulos v1
#define RELAY_FIRST_STATUS LOW
#define RELAY_SECOND_STATUS HIGH
// Módulos v5 e v4
// #define RELAY_FIRST_STATUS HIGH
// #define RELAY_SECOND_STATUS LOW

const char* ssid = "Dsum";
const char* password = "@Danielsum23";
// const char* ssid = "AMNET85_1450";
// const char* password = "hacker_cmt23";
// const char* ssid = "AMNET85_4095_EXT";
// const char* password = "Godofredo_2";

const int port = 80;
const char* host = "192.168.181.144";
// const char* host = "192.168.101.7";
const char* endpointGet = "/app_atalaia/api2/switches/getone";
const char* endpointUpdate = "/app_atalaia/api2/switches/toggle";
// const char* host = "atalaiaproject.000webhostapp.com";
// const char* endpointGet = "/switches/getone";
// const char* endpointUpdate = "/switches/toggle";

// Configurações do NTP
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org",  -3 * 3600, 60000);  // UTC -3 horas (Brasília), atualiza a cada 60 segundos

bool realStatus = false;
bool serverStatus = false;
bool switchGuardStatus = false;
bool guardStatus = false;
bool relayStatus = false;
time_t serverLatestDateTime = 0;
time_t guardLatestDateTime = 0;
time_t realLatestDateTime = 0;
time_t previousServerDateTime = 0;
time_t previousGuardDateTime = 0;
time_t previousRealDateTime = 0;


void setup()
{
  // Iniciando o relé
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, RELAY_FIRST_STATUS);

  // Iniciando a entrada do sensor de corrente
  resetSensorPin();

  // Iniciando o Serial Monitor
  Serial.begin(9600);
  delay(5000);
  Serial.println("");
  Serial.println("------------------------------");

  Serial.print("Endereço MAC: ");
  Serial.println(WiFi.macAddress());

  Serial.print("Leitura inicial do pino do sensor: ");
  Serial.println(digitalRead(SENSOR_PIN));

  // Iniciando a conexão com a internet
  startConnection();

  // Iniciando o controlador de tempo
  timeClient.begin();

  // Consultando a data e hora atual
  getFormattedCurrentTime();
}


void resetSensorPin()
{
  // Restabelecendo o pino do sensor de corrente
  /* Obs.: 
   * Essa abordagem representa um risco para a placa.
   * O mais recomendável seria fazer uso de um resistor 10k 1/4w,
   * ligando a GPIO utilizada com o GND
   */
  pinMode(SENSOR_PIN, OUTPUT); 
  digitalWrite(SENSOR_PIN, LOW);
  pinMode(SENSOR_PIN, INPUT);
}


void startConnection()
{
  Serial.print("Connecting to WiFi: ");
  Serial.println(ssid);

  // Iniciando o WiFi
  WiFi.begin(ssid, password);
  
  delay(10000);

  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("Successfully connected to WiFi!");
    Serial.print("Local IP Address: ");
    Serial.println(WiFi.localIP());
  } else {
    Serial.println("Connection failed!");
  }
}


void getFormattedCurrentTime()
{
  if (WiFi.status() == WL_CONNECTED) {
    time_t currentTime = getCurrentTime();
    String formattedDateTime = formatDateTime(currentTime);
    Serial.println("Data e hora atual: " + formattedDateTime);
  }
}


time_t getCurrentTime()
{
  Serial.println("Trying to access NTP: ");
  // Atualiza a hora do cliente NTP
  while(!timeClient.update()) {
    timeClient.forceUpdate();
    Serial.print(".")
  }

  Serial.println("Success");

  // Retorna a hora atual em segundos desde 1970
  return timeClient.getEpochTime();
}


time_t convertDateTimeToTimeT(String dateTimeStr)
{
  tmElements_t tm;

  int year, month, day, hour, minute, second;
  sscanf(dateTimeStr.c_str(), "%d-%d-%d %d:%d:%d", &year, &month, &day, &hour, &minute, &second);

  tm.Year = year - 1970;
  tm.Month = month;
  tm.Day = day;
  tm.Hour = hour;
  tm.Minute = minute;
  tm.Second = second;

  // Retorna o tempo em segundos desde 1970
  return makeTime(tm);
}


String formatDateTime(time_t t)
{
  char buffer[20];

  sprintf(buffer, "%04d-%02d-%02d %02d:%02d:%02d", 
          year(t), month(t), day(t), hour(t), minute(t), second(t));

  return String(buffer);
}


void loop()
{
  // Verifica se está conectado
  if (WiFi.status() == WL_CONNECTED) {
    getRealStatus();
    getServerStatus();

    resolveRelayStatus();
    updateSwitch();

    testRealStatus(); //debug
  } else {
    startConnection();
    timeClient.begin();
  }

  delay(1000);
}


void getRealStatus()
{
  bool temp = (digitalRead(SENSOR_PIN) == HIGH);

  resetSensorPin(); // É necessário restabelecer o pino, pois ele não volta sozinho para a posição LOW

  Serial.print("tempRealStatus: ");
  Serial.println(temp);

  if (realStatus != temp) {
    realStatus = temp;
    realLatestDateTime = timeClient.getEpochTime();
    Serial.print("RealStatus: ");
    Serial.println(realStatus);
    Serial.print("RealLatestDateTime: ");
    Serial.println(realLatestDateTime);
  }
}


void getServerStatus()
{
  String payload = requestStatus();

  if (!validatePayload(payload))
    return;

  readJson(payload);
}


String requestStatus()
{
  WiFiClient client;
  HTTPClient http;
  String payload = "";
  String macaddress = WiFi.macAddress();

  // Criando o body da requisição
  DynamicJsonDocument body(1024);
  body["mac_address"] = WiFi.macAddress();
  String bodyString;
  serializeJson(body, bodyString);

  Serial.print("Request Body: ");
  Serial.println(bodyString);

  Serial.println("Requesting switch status to the server...");

  // Tenta se conectar com a API
  if (http.begin(client, host, port, endpointGet)) {
    int httpCode = http.POST(bodyString);

    if (httpCode > 0) {
      payload = http.getString(); // Caso obtenha resposta atualiza a variável
      Serial.print("Request successful: ");
      Serial.println(payload);
    }

    http.end();
  }

  return payload;
}


bool validatePayload(String payload)
{
  if (payload == "") {
    Serial.println("Request failed!");
    Serial.println("Keeping the same status as before...");
    return false;
  }
  
  Serial.println("Payload validated!");

  return true;
}


void readJson(String payload)
{
  // Criando um buffer para armazenar o JSON
  DynamicJsonDocument doc(1024);

  // Fazendo o parsing do JSON
  DeserializationError error = deserializeJson(doc, payload);
  if (error) {
    Serial.print("Failed to parse JSON: ");
    Serial.println(error.c_str());
    Serial.println("Keeping the same status as before...");
    return;
  } 

  Serial.println("JSON parse successful!");

  if (!doc.containsKey("dados")) {
    Serial.println("Key 'dados' not found in JSON.");
    return;
  }

  JsonObject dados = doc["dados"].as<JsonObject>();

  if (!dados.containsKey("updated_at")) {
    Serial.println("Updated_at: The last update of the switch is unknown.");
    Serial.println("Keeping the same status as before...");
    return;
  }

  int isActive = dados.containsKey("is_active") ? dados["is_active"].as<int>() : 2;
  int guardActive = dados.containsKey("guard_active") ? dados["guard_active"].as<int>() : 2;
  int guardIsOn = dados.containsKey("guard_is_on") ? dados["guard_is_on"].as<int>() : 2;

  String updatedAt = dados["updated_at"];
  serverLatestDateTime = convertDateTimeToTimeT(updatedAt);
  String guardUpdatedAt = dados["guard_updated_at"];
  guardLatestDateTime = convertDateTimeToTimeT(guardUpdatedAt);

  switch (isActive) {
    case 0:
      Serial.println("Is_active: The switch is inactive on the server.");
      serverStatus = false;
      break;
    case 1:
      Serial.println("Is_active: The switch is active on the server.");
      serverStatus = true;
      break;
    default:
      Serial.println("Is_active: The is_active of the switch is unknown.");
      Serial.println("Keeping the same status as before...");
      return;
  }

  switch (guardActive) {
    case 0:
      Serial.println("Guard_active: The switch guard status is inactive on the server.");
      switchGuardStatus = false;
      break;
    case 1:
      Serial.println("Guard_active: The switch guard status is active on the server.");
      switchGuardStatus = true;
      break;
    default:
      Serial.println("Guard_active: The guard_active of the switch is unknown.");
      Serial.println("Keeping the same status as before...");
      return;
  }

  switch (guardIsOn) {
    case 0:
      Serial.println("Guard_is_on: The user's guard is inactive on the server.");
      guardStatus = false;
      break;
    case 1:
      Serial.println("Guard_is_on: The user's guard is active on the server.");
      guardStatus = true;
      break;
    default:
      Serial.println("Guard_is_on: The guard_is_on of the user is unknown.");
      Serial.println("Keeping the same status as before...");
      return;
  }
}


bool isDateServerDiff()
{
  return (previousServerDateTime != serverLatestDateTime);
}


bool isDateRealDiff()
{
  return (previousRealDateTime != realLatestDateTime);
}


bool isDateGuardDiff()
{
  return (previousGuardDateTime != guardLatestDateTime);
}


void resolveRelayStatus()
{
  if (!guardStatus && serverStatus != realStatus) {
    if (isDateServerDiff() || isDateRealDiff()) {
      if (serverLatestDateTime > realLatestDateTime) {
        relayStatus = relayStatus ? false : true;
      }
    } else {
      updateStatus();
    }
  }

  if (guardStatus && switchGuardStatus != realStatus) {
    if (isDateGuardDiff() || isDateRealDiff()) {
      if (guardLatestDateTime > realLatestDateTime) {
        relayStatus = relayStatus ? false : true;
      }
    } else {
      updateStatus();
    }
  }

  previousServerDateTime = serverLatestDateTime;
  previousGuardDateTime = guardLatestDateTime;
  previousRealDateTime = realLatestDateTime;

  Serial.print("guardStatus: ");
  Serial.println(guardStatus);
  Serial.print("serverStatus: ");
  Serial.println(serverStatus);
  Serial.print("realStatus: ");
  Serial.println(realStatus);
  Serial.print("switchGuardStatus: ");
  Serial.println(switchGuardStatus);
  Serial.print("relayStatus: ");
  Serial.println(relayStatus);
  Serial.print("serverLatestDateTime: ");
  Serial.println(serverLatestDateTime);
  Serial.print("realLatestDateTime: ");
  Serial.println(realLatestDateTime);
}


void updateStatus()
{
  WiFiClient client;
  HTTPClient http;
  String payload = "";
  String macaddress = WiFi.macAddress();

  DynamicJsonDocument body(1024);
  body["mac_address"] = WiFi.macAddress();
  String bodyString;
  serializeJson(body, bodyString);

  Serial.print("Request Body: ");
  Serial.println(bodyString);

  Serial.println("Updating switch status on the server...");

  // Tenta se conectar com a API
  if (http.begin(client, host, port, endpointUpdate)) {
    int httpCode = http.POST(bodyString);

    if (httpCode > 0) {
      payload = http.getString(); // Caso obtenha resposta atualiza a variável
      Serial.print("Update successful: ");
      Serial.println(payload);
    }

    http.end();
  }
}


void updateSwitch()
{
  if (relayStatus == true) {
    Serial.print("Sending switch Activation input... ");
    digitalWrite(RELAY_PIN, RELAY_SECOND_STATUS);
    Serial.println("Done!");
  } else {
    Serial.print("Sending switch Deactivation input... ");
    digitalWrite(RELAY_PIN, RELAY_FIRST_STATUS);
    Serial.println("Done!");
  }
}


void testRealStatus()
{
  if (Serial.available() > 0) {
    char command = Serial.read();
    if (command == 'r') {
      pinMode(SENSOR_PIN, OUTPUT); 
      digitalWrite(SENSOR_PIN, HIGH);
      pinMode(SENSOR_PIN, INPUT);
    }
  }
}


