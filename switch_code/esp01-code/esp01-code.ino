#include <ESP8266WiFi.h>
#include <EEPROM.h>

// Simula uma memória física para guardar o ssid e password
#define EEPROM_SSID_ADDRESS 0
#define EEPROM_PASSWORD_ADDRESS 50

// Definindo o tamanho mínimo de senha
#define MIN_PASSWORD_LENGTH 8

// Pino conectado ao relé
const int relayPin = 0; // GPIO0

char ssid[50];
char password[50];


void setup() {
  Serial.begin(9600);
  delay(10000);

  // Acessando o LED
  pinMode(LED_BUILTIN, OUTPUT);

  // Inicializando o relé
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, LOW);

  // Recuperando os dados de ssid e password
  getEEPROM();

  // Verificando se os dados recuperados são válidos
  if(strlen(ssid) > 0 && strlen(password) >= MIN_PASSWORD_LENGTH){
    startConnection();
  } else {
    startWPS();
  }
}


void getEEPROM(){
  Serial.println("Recuperando SSID e Password");

  EEPROM.begin(512);

  EEPROM.get(EEPROM_SSID_ADDRESS, ssid);
  EEPROM.get(EEPROM_PASSWORD_ADDRESS, password);

  EEPROM.end();

  Serial.println("SSID: ");
  Serial.println(ssid);
  Serial.println("Password: ");
  Serial.println(password);
  Serial.println("Recuperado com sucesso!!");
}


void setEEPROM(){
  Serial.println("Armazenando SSID e Password");

  EEPROM.begin(512);

  EEPROM.put(EEPROM_SSID_ADDRESS, WiFi.SSID());
  EEPROM.put(EEPROM_PASSWORD_ADDRESS, WiFi.psk());

  EEPROM.commit();
  EEPROM.end();

  Serial.println("SSID: ");
  Serial.println(WiFi.SSID());
  Serial.println("Password: ");
  Serial.println(WiFi.psk());
  Serial.println("Salvo com sucesso!!");
}


void startWPS(){
  Serial.println("Entrando no modo WPS...");

  // Iniciando o modo Wifi
  WiFi.mode(WIFI_STA);

  // Iniciando o WPS
  int status = WiFi.beginWPSConfig();
  if (status) {
      Serial.println("WPS iniciado. Aguardando conexão...");

      int counter = 0;
      while (counter < 30) {
        counter++;
        digitalWrite(LED_BUILTIN, LOW);
        delay(500);
        Serial.print(".");
        digitalWrite(LED_BUILTIN, HIGH);
        delay(500);
        Serial.print(".");
      }
  } else {
      Serial.println("Falha ao iniciar WPS.");
  }

  Serial.println("");

  if (WiFi.status() != WL_CONNECTED) {
      Serial.println("Falha ao conectar-se via WPS após várias tentativas. Verifique se o WPS está habilitado no seu roteador.");
  } else {
      Serial.println("Conectado com sucesso ao WiFi!");
      Serial.println("Local IP Address: ");
      Serial.println(WiFi.localIP());

      setEEPROM();
  }
}


void startConnection() {

  Serial.println("Conectando ao WiFi: ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);
  
  int counter = 0;
  while (counter < 10) {
    counter++;
    digitalWrite(LED_BUILTIN, LOW);
    delay(500);
    Serial.print(".");
    digitalWrite(LED_BUILTIN, HIGH);
    delay(500);
    Serial.print(".");
  }

  Serial.println("");

  if(WiFi.status() == WL_CONNECTED){
    Serial.println("Conectado com sucesso ao WiFi!");
    Serial.println("Local IP Address: ");
    Serial.println(WiFi.localIP());
  } else {
    Serial.println("A conexão falhou!");
  }
}


void askForWPS() {
  // Método físico (botão)
  // if (digitalRead(buttonPin) == HIGH) {
  //   startWPS();
  // }

  // Método de monitor
  if (Serial.available() > 0) {
    char command = Serial.read();
    if (command == 'W') {
      startWPS(); // Inicia o modo WPS se o comando 'W' for recebido
    }
  }
}


void switchOn() {
    if(digitalRead(relayPin) == LOW) {
      digitalWrite(relayPin, HIGH);
    } else {
      digitalWrite(relayPin, LOW);
    }
}


void loop() {
  askForWPS();
  switchOn();

  if (WiFi.status() == WL_CONNECTED) {

    digitalWrite(LED_BUILTIN, LOW);
    delay(2000);

  } else {

    digitalWrite(LED_BUILTIN, HIGH);
    delay(2000);
    startConnection();
  }
}