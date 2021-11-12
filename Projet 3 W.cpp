#include <BME280I2C.h>
#include <SD.h>
#include <Wire.h> 
#include "DS1307.h"
#include <RTClib.h>
#include <ChainableLED.h>
#include <EEPROM.h>

// lire les données du capteur d'hygrométrie

//#include <Adafruit_Sensor.h>
//#include <Adafruit_BME280.h>

#define SEALEVELPRESSURE_HPA (1013.25)
#define NUM_LEDS 1
#define nomDuFichier "WWW.txt"       

DS1307 clock;//define a object of DS1307 class
RTC_DS1307 rtc;
File monFichier;
ChainableLED leds(7, 8, NUM_LEDS);

bool error_status=false;
float LOG_INTERVAL= 10000;
int i = 1; 

byte boutonVert=3;
byte boutonRouge=2;
long time1 = millis();

const byte lancement=1;
const byte standard=2;
const byte configuration=3;
const byte economique=4;
const byte maintenance=5;
const byte test_bouton_Rouge=6;
const byte test_bouton_Vert=7;

byte mode=lancement;
byte mode_bis=mode;

////////////////////////////////////////
////////////////////////////////////////
BME280I2C::Settings settings(
   BME280::OSR_X1,
   BME280::OSR_X1,
   BME280::OSR_X1,
   BME280::Mode_Forced,
   BME280::StandbyTime_1000ms,
   BME280::Filter_Off,
   BME280::SpiEnable_False,
   BME280I2C::I2CAddr_0x76 // I2C address. I2C specific.
);

BME280I2C bme(settings);

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

// initialisation de la carte SD
void SD_ini(){
  SD.begin(4);
  if(!SD.begin(4)){
    Serial.println(F("L'initialisation a échouée"));
    leds.setColorRGB(0, 255, 0, 0);
    delay(1000);
    leds.setColorRGB(0, 255, 255, 255);
    delay(1000);
    
    return;
  }
  Serial.println(F("L'initialisation de la carte SD a réussi"));
}
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
// initialisation de l'EEPROM avec nos valeur  
void EEPROM_ini(){

    EEPROM.put(0, 60000); // LOG_INTERVALL en ms
    EEPROM.put(2, 4096); // FILE_MAX_SIZE soit 4096 octets
    EEPROM.put(4, 30); // TIMEOUT
    EEPROM.put(6, 1); // LUMIN
    EEPROM.put(8, 255); // LUMIN_LOW
    EEPROM.put(10, 768); // LUMIN_HIGH
    EEPROM.put(12, 1); // TEMP_AIR
    EEPROM.put(14, -10); // MIN_TEMP_AIR
    EEPROM.put(16, 60); // MAX_TEMP_AIR
    EEPROM.put(18, 1); // HYGR
    EEPROM.put(20, 0); // HYGR_MINT
    EEPROM.put(22, 50); // HYGR_MAXT
    EEPROM.put(24, 1); // PRESSURE
    EEPROM.put(26, 850); // PRESSURE_MIN
    EEPROM.put(28, 1080); // PRESSURE_MAX
    Serial.println("EEPROM DEFAULT");

// 1023 registres disponibles dans l'EEPROM mais la mémoire est lente
}
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
void changement_EEPROM(){
    int rep;
    String enter;
    Serial.println(F("modif?"));
    delay(2000);
    rep=Serial.read();
    rep = rep - 48;
    Serial.println(rep);
    
    if(Serial.available()>0){
    switch(rep){

        case 1:
                Serial.println(F("Log inter?"));
                while(Serial.available()>0){
                    enter = Serial.readString();
                    if(enter!=0){
                        Serial.println(enter);
                        EEPROM.put(0,enter.toInt());
                        Serial.println(F("Val changed"));
                        break;
                    }
                    break;
                }
                break;
        case 2:

                Serial.println(F("Max size?"));
                while(Serial.available()>0){
                    enter = Serial.readString();
                    if(enter!=0){
                        Serial.println(enter);
                        EEPROM.put(2,enter.toInt());
                        Serial.println(F("Val changed"));
                        break;
                    }
                    break;
                }
                break;

        case 3:

                void EEPROM_ini();
                Serial.println("--DEFAULT");
                break;

        
        case 4:

                Serial.println(F("V 1.0245"));
                Serial.println(F("n 42"));
                break;

        
        case 5:
            
                Serial.println(F("Timeout?"));
                while(Serial.available()>0){
                    enter = Serial.readString();
                    if(enter!=0){
                        Serial.println(enter);
                        EEPROM.put(4,enter.toInt());
                        Serial.println(F("Val changed"));
                        break;
                    }
                    break;
                }
                break;
        }
    }
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


void test_bouton_R(){
  mode = test_bouton_Rouge;
}

void test_bouton_V(){
  mode = test_bouton_Vert;
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


void interruption_red_button(){
  attachInterrupt(digitalPinToInterrupt(boutonRouge), test_bouton_R, FALLING);
}

void interruption_green_button(){
  attachInterrupt(digitalPinToInterrupt(boutonVert), test_bouton_V, FALLING);
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

boolean appuieLong(byte bouton_appuyer){
  for (int i = 1; i <= 10; i++){
    if (digitalRead(bouton_appuyer)){
      return false;
      break;
    }
    else if (i == 10){
      return true;
    }
    delay(500);
  }
}


//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

void BME280_Rdata(float *t, float *hu, float *p)
{
  float temp(NAN), hum(NAN), pres(NAN);
   BME280::TempUnit tempUnit(BME280::TempUnit_Celsius);
   BME280::PresUnit presUnit(BME280::PresUnit_Pa);

   

   bme.read(pres, temp, hum, tempUnit, presUnit);
   *t=temp;
   *hu=hum;
   *p=pres;

   Serial.print(temp);
   Serial.print("-");
   Serial.print(hum);
   Serial.print("-");
   Serial.print(pres);
   Serial.println(" ");
}
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

void DS1307_Rdata(int *y, int *mon, int *d, int *h, int* min_, int *sec)
{
  DateTime now = rtc.now();

   *y = now.year();
   *mon = now.month();
   *d = now.day();
   *h = now.hour();
   *min_ = now.minute();
   *sec = now.second();
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

 int W_on_SD(int *y, int *mon, int *d, int *h, int *min_, int *sec, int *lumen, float *t, float *hu, float *p, int *i){
  monFichier = SD.open(nomDuFichier, FILE_WRITE);
  if (monFichier) {

    monFichier.print(*y);
    monFichier.print(",");
    monFichier.print(*mon);
    monFichier.print(",");
    monFichier.print(*d);
    monFichier.print(",");
    monFichier.print(*h);
    monFichier.print(",");
    monFichier.print(*min_);
    monFichier.print(",");
    monFichier.print(*sec); // Horloge RTC
    monFichier.print(",");

    monFichier.print(*lumen); // Light sensor
    monFichier.print(","); // enlver ln quand sensor write BME fonctionne

    monFichier.print(*t);
    monFichier.print(",");
    monFichier.print(*hu);
    monFichier.print(",");
    monFichier.println(*p);// BME280
    
 
    
    
    
    monFichier.close();                           // Fermeture du fichier
    //Serial.println("Écriture terminée");
  }
  else {
    //Serial.println(F("Échec d'ouverture en écriture, pour le fichier '" nomDuFichier "', sur la carte SD !"));
    while (1);    // Boucle infinie (arrêt du programme)
  }
  Serial.println();

}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

void setup(){
  Serial.begin(9600);
  interruption_red_button();
  interruption_green_button();
  EEPROM_ini();
  Wire.begin();
  rtc.begin();
  
  while(!Serial) {} // Wait

  while(!bme.begin())
  {
    Serial.println("not find BME280I2C");
    delay(1000);
  }

  switch(bme.chipModel())
  {
     case BME280::ChipModel_BME280:
       Serial.println("Found BME280 Success.");
       break;
     case BME280::ChipModel_BMP280:
       Serial.println("Found BMP280,No Humidity available.");
       break;
     default:
       Serial.println("Found UNKNOWN sensor! Error!");
  }
    SD_ini();
   // Change some settings before using.
   settings.tempOSR=BME280::OSR_X4;

   bme.setSettings(settings);
}
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
void mode_standard(long *time1){
  int y, mon, d, h, min_, sec;
  int lumen = analogRead(0);
   float t, hu, p;
    leds.setColorRGB(0, 0, 255, 0);
  if (millis() - *time1 > LOG_INTERVAL){
     BME280_Rdata(&t, &hu, &p);
    DS1307_Rdata(&y, &mon, &d, &h, &min_, &sec);
    W_on_SD(&y, &mon, &d, &h, &min_, &sec, &lumen, &t, &hu, &p,&i);
    *time1 = millis();

  }
   
}

void mode_economique(long *time1){
  int y, mon, d, h, min_, sec;
  int lumen = analogRead(0);
  float t, hu, p;
    leds.setColorRGB(0, 0, 0, 255);
    if (millis() - *time1 > LOG_INTERVAL*2){
    BME280_Rdata(&t, &hu, &p);
    DS1307_Rdata(&y, &mon, &d, &h, &min_, &sec);
    W_on_SD(&y, &mon, &d, &h, &min_, &sec, &lumen, &t, &hu, &p, &i);
    *time1 = millis();
}
}

void mode_maintenance(long *time1){
  int y, mon, d, h, min_, sec;
  int lumen = analogRead(0);
  float t, hu, p;
    leds.setColorRGB(0, 255, 127, 0);
    if (millis() - *time1 > 5000){
    BME280_Rdata(&t, &hu, &p);
    DS1307_Rdata(&y, &mon, &d, &h, &min_, &sec);
    SD_ini();
    *time1= millis();
}
}

void mode_configuration(){
  leds.setColorRGB(0, 255, 127, 0);
  changement_EEPROM();
  if (millis() >= 30000){
      mode = standard;
      Serial.println("Config -> Stand");
      }
  delay(1000);
  
}


//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

void Changement_mode(byte *a_mode, long *time1){
  switch(*a_mode){
    case lancement:
    if (millis() < 1000 && digitalRead(boutonRouge) == LOW){
      mode = configuration;
      mode_bis = standard;
      Serial.print("mode config");
      delay(2000);
      break;
    }
    else if(millis() < 1000){
      Serial.println("mode stand");
      mode = standard;
      mode_bis = standard;
      break;
    }
 

  case configuration:
    mode_configuration();
    //Serial.println("case conf");
    
  
  case standard:
    mode_standard(time1);
    //Serial.println("case standard");
    break;
 
  
  case economique:
    mode_economique(time1);
    //Serial.println("case eco");
    break;
  
  case maintenance:
    mode_maintenance(time1);
    //Serial.println("case maintenance");
    break;

  case test_bouton_Rouge:
    if (appuieLong(boutonRouge) == true){
    if (mode_bis == standard){
      Serial.println("stand -> maint");
      mode = maintenance;
      mode_bis = mode;
      break;
    }
      else if (mode_bis == maintenance){
      Serial.println("maint -> eco");
      mode = economique;
      mode_bis = mode;
      break;
    }   
    else if (mode_bis == economique){
      Serial.println("eco -> stand");
      mode = standard;
      mode_bis = mode;
      break;
    }
  }
  else 
    mode = mode_bis;
    break;
  
  case test_bouton_Vert:
    if (appuieLong(boutonVert) == true){
    if (mode_bis == standard){
      Serial.println("stand -> eco");
      mode = economique;
      mode_bis = mode;
      break;
    }
    
  else if (mode_bis == economique){
      Serial.println("eco -> maint");
      mode = maintenance;
      mode_bis = mode;
      break;
    }
    else if (mode_bis == maintenance){
      Serial.println("maint -> stand");
      mode = standard;
      mode_bis = mode;
      break;
    }
  }
  else 
    mode = mode_bis;
    break;

  }
}

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////




void loop()
{
  Changement_mode(&mode, &time1);
}






