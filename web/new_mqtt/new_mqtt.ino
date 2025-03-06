#include <WiFi.h>
#include <PubSubClient.h>
#include <ESP32Servo.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// WiFi credentials
const char* ssid = "AR Cubers";
const char* password = "arcubers";

// MQTT broker details
const char* mqttServer = "test.mosquitto.org";  // Replace with your MQTT broker address
const int mqttPort = 1883;

// Topic to publish
#define MQTT_PUB_DISTANCE "radar/object/distance"
#define MQTT_SUB_DOOR_STATUS "door/control"
#define MQTT_SUB_OPTION "choose/options"

// LCD setup (I2C address 0x27, 16x2 display)
LiquidCrystal_I2C lcd(0x27, 20, 4);

// Pin definitions for the ultrasonic sensor
#define TRIG_PIN 5
#define ECHO_PIN 18
#define SERVO_PIN 19
#define BUZZER_PIN 23
#define RELAY_PIN 2

// Distance threshold to open the dustbin (in cm)
const int thresholdDistance = 25;
float distance;

// Create a Servo object
Servo servo;

WiFiClient espClient;
PubSubClient client(espClient);

// Define the message to scroll
const char* message = "Welcome to Radar system automation with Home security and automated dustbin project created by Gulam and Khalid";

// Function to connect to Wi-Fi
void setupWiFi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
}
// Callback function to handle incoming messages
void callback(char* topic, byte* payload, unsigned int length) {

  String message = String((char*)payload);  // Convert payload to String
  Serial.print("Received message on topic: ");
  Serial.println(topic);
  Serial.print("Message content: ");
  Serial.println(message);
  Serial.print("Message: ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);  // Print each character of the message
  }
  Serial.println();
  // Check if the topic is the subscribed topic
  if (String(topic) == String(MQTT_SUB_OPTION)) {
    if (message == "object_detection") {
      Radar_system(distance);
    } else if (message == "dustbin") {
      dustbin_system(distance);
    }
  }
}

// Function to connect to MQTT
void reconnectMQTT() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("rupesh")) {
      Serial.println("connected");
      client.subscribe("MQTT_SUB_OPTION");  // Subscribe to the topic
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

// Function to calculate distance from Ultrasonic sensor
float getDistance() {
  // Send a pulse to trigger pin
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  // Measure the duration of echo pulse
  long duration = pulseIn(ECHO_PIN, HIGH);

  // Calculate distance in cm (Speed of sound is 343 m/s or 0.0343 cm/µs)
  float distance = duration * 0.0343 / 2;

  return distance;
}

// Function for automatic dustbin system
void dustbin_system(float distance) {
  // Initial LCD message
  lcd.setCursor(0, 0);
  lcd.print("DUSTBIN AUTOMATION INIT...");
  Serial.print("Starting dustbin System....");

  // If the distance is below the threshold, open the dustbin
  if (distance < thresholdDistance) {
    Serial.println("Opening dustbin...");
    servo.write(90);                 // Open dustbin to 90 degrees
    digitalWrite(BUZZER_PIN, HIGH);  // Turn on buzzer
    delay(1000);                     // Buzzer for 1 second
    digitalWrite(BUZZER_PIN, LOW);   // Turn off buzzer
    delay(2000);                     // Keep the dustbin open for 2 more seconds
    servo.write(0);                  // Close the dustbin
  }

  delay(100);  // Brief delay to avoid spamming the sensor
}

// Function for radar system operation
void Radar_system(float distance) {
  // Initial LCD message
  lcd.setCursor(0, 0);
  lcd.print("Radar System Init...");
  Serial.print("Starting Radar System....");
  delay(2000);
  lcd.clear();

  // If the distance is below the threshold
  if (distance < thresholdDistance) {
    lcd.setCursor(0, 0);
    lcd.print("Object Detected! ");
    Serial.println("Object Detected! ");
    lcd.setCursor(0, 1);
    lcd.print("Distance: ");
    lcd.print(distance);
    lcd.print(" cm ");

    // Sound the buzzer
    digitalWrite(BUZZER_PIN, HIGH);
    delay(500);
    digitalWrite(BUZZER_PIN, LOW);

  } else {
    // If no object detected, display "Scanning..."
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("Scanning...");
  }
}
void setup() {
  Serial.begin(115200);
  Serial.println("\nStarting Radar Detection and Ranging with Automation and Security Application....");

  // Initialize the LCD
  lcd.begin();
  lcd.backlight();  // Turn on the backlight

  // // Clear the LCD
  // lcd.clear();

  // lcd.setCursor(8, 1);
  // Serial.println("INTO SCREEN....");
  // // Print the scrolling text
  // for (int i = 0; i < message.length(); i++) {
  //   if (i == message.length() - 14) {
  //     break;
  //   }
  //   lcd.setCursor(0, 0);
  //   lcd.print(message.substring(i, i + 16));

  //   delay(300);  // Adjust the scrolling speed here
  // }

  // // Clear the LCD
  // lcd.clear();

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(RELAY_PIN, OUTPUT);

  // Attach the servo motor and set it to the closed position
  servo.attach(SERVO_PIN);
  servo.write(0);  // Servo at 0 degrees (closed position)

  setupWiFi();
  client.setServer(mqttServer, mqttPort);
  client.setCallback(callback);  // Set the callback function for incoming messages

  // Initial connection to MQTT
  reconnectMQTT();
}

void loop() {
  if (!client.connected()) {
    reconnectMQTT();
  }
  client.loop();

  // Read the distance from ultrasonic sensor
  distance = getDistance();
  // Serial.print("Distance: ");
  // Serial.println(distance);

  // // Publish the distance value to MQTT
  // char msg[50];
  // dtostrf(distance, 6, 2, msg);
  // client.publish(MQTT_PUB_DISTANCE, msg);
  // Serial.print("Publishing at QoS 2, MESSAGE: ");
  // Serial.println(distance);

  // // Wait 2 seconds before reading and publishing again
  // delay(2000);
}
