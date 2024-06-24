#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
// #include <EEPROM.h>
#include <ArduinoJson.h>

#define RELAY_PIN 0
#define LED_FIRST_STATUS LOW
#define LED_SECOND_STATUS HIGH

// Módulos v1
// #define RELAY_FIRST_STATUS LOW
// #define RELAY_SECOND_STATUS HIGH
// Módulos v5 e v4
#define RELAY_FIRST_STATUS HIGH
#define RELAY_SECOND_STATUS LOW

// const char* ssid = "Dsum";
// const char* password = "@Danielsum23";
const char* ssid = "AMNET85_1450";
const char* password = "hacker_cmt23";
// const char* ssid = "AMNET85_4095_EXT";
// const char* password = "Godofredo_2";

const int port = 80;
// const char* host = "192.168.181.144";
// const char* host = "192.168.101.7";
const char* host = "192.168.101.8";
const char* endpointGet = "/app_atalaia/api2/switches/getone";
// const char* host = "atalaiaproject.000webhostapp.com";
// const char* endpointGet = "/switches/getone";

bool serverStatus = false;
bool switchGuardStatus = false;
bool guardStatus = false;
bool relayStatus = false;


void setup()
{
  // Inicializando o relé
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, RELAY_FIRST_STATUS);

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
    digitalWrite(LED_BUILTIN, LED_FIRST_STATUS);
    delay(500);
    Serial.print(".");
    digitalWrite(LED_BUILTIN, LED_SECOND_STATUS);
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
    digitalWrite(LED_BUILTIN, LED_FIRST_STATUS);

    getServerStatus();

    resolveRelayStatus();
    updateSwitch();

    // relayStatus = isStatus();
    // updateSwitch(relayStatus);
  } else {
    digitalWrite(LED_BUILTIN, LED_SECOND_STATUS);
    startConnection();
  }

  delay(1000);
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


// bool isStatus()
// {
//   String payload = requestStatus();

//   bool status = readPayload(payload);

//   return status;
// }


// String requestStatus()
// {
//   WiFiClient client;
//   HTTPClient http;
//   String payload = "";
//   String macaddress = WiFi.macAddress();

//   // Criando o body da requisição
//   DynamicJsonDocument body(1024);
//   body["mac_address"] = WiFi.macAddress();
//   String bodyString;
//   serializeJson(body, bodyString);

//   Serial.print("Request Body: ");
//   Serial.println(bodyString);

//   Serial.println("Requesting switch status to the server...");

//   // Tenta se conectar com a API
//   if (http.begin(client, host, port, endpointGet)) {
//     int httpCode = http.POST(bodyString);

//     if (httpCode > 0) {
//       payload = http.getString(); // Caso obtenha resposta atualiza a variável
//       Serial.print("Request successful: ");
//       Serial.println(payload);
//     }

//     http.end();
//   }

//   return payload;
// }


// bool readPayload(String payload)
// {
//   if (payload == "") {
//     Serial.println("Request failed");
//     Serial.println("Keeping the same status as before...");
//     return relayStatus;
//   }

//   // Criando um buffer para armazenar o JSON
//   DynamicJsonDocument doc(1024);

//   // Fazendo o parsing do JSON
//   DeserializationError error = deserializeJson(doc, payload);
//   if (error) {
//     Serial.print("Failed to parse JSON: ");
//     Serial.println(error.c_str());
//     Serial.println("Keeping the same status as before...");
//     return relayStatus;
//   }

//   Serial.println("JSON parse successful!");

//   if (!dados.containsKey("updated_at")) {
//     Serial.println("Updated_at: The last update of the switch is unknown.");
//     Serial.println("Keeping the same status as before...");
//     return;
//   }

//   int isActive = dados.containsKey("is_active") ? dados["is_active"].as<int>() : 2;
//   int guardActive = dados.containsKey("guard_active") ? dados["guard_active"].as<int>() : 2;
//   int guardIsOn = dados.containsKey("guard_is_on") ? dados["guard_is_on"].as<int>() : 2;

//   switch (guardIsOn) {
//     case 0:
//       Serial.println("Guard_is_on: The user's guard is inactive on the server.");
//       guardStatus = false;
//       break;
//     case 1:
//       Serial.println("Guard_is_on: The user's guard is active on the server.");
//       guardStatus = true;
//       break;
//     default:
//       Serial.println("Guard_is_on: The guard_is_on of the user is unknown.");
//       Serial.println("Keeping the same status as before...");
//       return;
//   }

//   switch (isActive) {
//     case 0:
//       Serial.println("Status: The switch is inactive on the server.");
//       return false;
//     case 1:
//       Serial.println("Status: The switch is active on the server.");
//       return true;
//     default:
//       Serial.println("Status: The status of the switch is unknown.");
//       Serial.println("Keeping the same status as before...");
//       return relayStatus;
//   }

//   switch (guardIsOn) {
//     case 0:
//       Serial.println("Guard_is_on: The user's guard is inactive on the server.");
//       guardStatus = false;
//       break;
//     case 1:
//       Serial.println("Guard_is_on: The user's guard is active on the server.");
//       guardStatus = true;
//       break;
//     default:
//       Serial.println("Guard_is_on: The guard_is_on of the user is unknown.");
//       Serial.println("Keeping the same status as before...");
//       return;
//   }
// }


void resolveRelayStatus()
{
  if (!guardStatus) {
    relayStatus = serverStatus;
  } else {
    relayStatus = switchGuardStatus;
  }

  Serial.print("guardStatus: ");
  Serial.println(guardStatus);
  Serial.print("serverStatus: ");
  Serial.println(serverStatus);
  Serial.print("switchGuardStatus: ");
  Serial.println(switchGuardStatus);
  Serial.print("relayStatus: ");
  Serial.println(relayStatus);
}


void updateSwitch()
{
  if (relayStatus == true) {
    Serial.println("Sending switch Activation input... ");
    digitalWrite(RELAY_PIN, RELAY_SECOND_STATUS);
  } else {
    Serial.println("Sending switch Deactivation input... ");
    digitalWrite(RELAY_PIN, RELAY_FIRST_STATUS);
  }
}
