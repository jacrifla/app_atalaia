#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
// #include <EEPROM.h>
#include <ArduinoJson.h>

const char* ssid = "AMNET85_1450";
const char* password = "hacker_cmt23";
// const char* ssid = "AMNET85_4095_EXT";
// const char* password = "Godofredo_2";

const char* host = "192.168.101.7";
const char* endpointGet = "/app_atalaia/api2/switches/getone";
// const char* host = "atalaiaproject.000webhostapp.com";
// const char* endpointGet = "/switches/getone";
const int port = 80;

bool relayState = false; // Estado inicial do relé

const int relayPin = 0;
const int ledStatus1 = LOW;
const int ledStatus2 = HIGH;

// Módulos v5 e v4
const int relayStatus1 = HIGH;
const int relayStatus2 = LOW;

// Módulos v1
// const int relayStatus1 = LOW;
// const int relayStatus2 = HIGH;


void setup()
{
  // Inicializando o relé
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, relayStatus1);

  //Acessando o LED
  pinMode(LED_BUILTIN, OUTPUT);

  Serial.begin(9600);
  delay(5000);
  Serial.println("");
  Serial.println("------------------------------");
  Serial.print("Endereço MAC: ");
  Serial.println(WiFi.macAddress());

  // Inicializando a conexão com a internet
  startConnection();
}

void startConnection()
{
  Serial.print("Connecting to WiFi: ");
  Serial.println(ssid);

  // Iniciando o WiFi
  WiFi.begin(ssid, password);
  
  int counter = 0;
  while (counter < 10) {
    counter++;
    digitalWrite(LED_BUILTIN, ledStatus1);
    delay(500);
    Serial.print(".");
    digitalWrite(LED_BUILTIN, ledStatus2);
    delay(500);
    Serial.print(".");
  }
  Serial.println("");

  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("Successfully connected to WiFi!");
    Serial.print("Local IP Address: ");
    Serial.println(WiFi.localIP());
  } else {
    Serial.println("Connection failed!");
  }
}

void loop()
{
  // Verifica se está conectado
  if (WiFi.status() == WL_CONNECTED) {
    digitalWrite(LED_BUILTIN, ledStatus1);

    relayState = isStatus();
    updateSwitch(relayState);
  } else {
    digitalWrite(LED_BUILTIN, ledStatus2);
    startConnection();
  }

  delay(1000);
}

bool isStatus()
{
  String payload = requestStatus();

  bool status = readPayload(payload);

  return status;
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

bool readPayload(String payload)
{
  if (payload == "") {
    Serial.println("Request failed");
    Serial.println("Keeping the same status as before...");
    return relayState;
  }

  // Criando um buffer para armazenar o JSON
  DynamicJsonDocument doc(1024);

  // Fazendo o parsing do JSON
  DeserializationError error = deserializeJson(doc, payload);
  if (error) {
    Serial.print("Failed to parse JSON: ");
    Serial.println(error.c_str());
    Serial.println("Keeping the same status as before...");
    return relayState;
  }

  int status = doc["dados"].containsKey("is_active") ? doc["dados"]["is_active"].as<int>() : 2;

  // Devolvendo o status presente no servidor
  switch (status) {
    case 0:
      Serial.println("Status: The switch is inactive on the server.");
      return false;
    case 1:
      Serial.println("Status: The switch is active on the server.");
      return true;
    default:
      Serial.println("Status: The status of the switch is unknown.");
      Serial.println("Keeping the same status as before...");
      return relayState;
  }
}

void updateSwitch(bool relayState)
{
  if (relayState == true) {
    Serial.println("Sending switch Activation input... ");
    digitalWrite(relayPin, relayStatus2);
  } else {
    Serial.println("Sending switch Deactivation input... ");
    digitalWrite(relayPin, relayStatus1);
  }
}
