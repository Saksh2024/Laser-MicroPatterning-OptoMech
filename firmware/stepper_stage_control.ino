/*
  Direct Laser Writing: 3-Axis Stepper Motion Control Firmware
  Author: Sakshi Tandel (IIT Kharagpur)
  Hardware: Arduino Uno + CNC Shield V3 / L298N Stepper Motor Drivers
  Motors: NEMA 17 Stepper Motors (X, Y, Z translation stage)
*/

// Pin assignments for CNC Shield
const int stepX = 2;
const int dirX  = 5;
const int stepY = 3;
const int dirY  = 6;
const int stepZ = 4;
const int dirZ  = 7;
const int enablePin = 8;

// Calibration parameters: steps per millimeter
const float STEPS_PER_MM_X = 200.0;
const float STEPS_PER_MM_Y = 200.0;
const float STEPS_PER_MM_Z = 400.0;

void setup() {
  Serial.begin(115200);
  pinMode(stepX, OUTPUT);
  pinMode(dirX, OUTPUT);
  pinMode(stepY, OUTPUT);
  pinMode(dirY, OUTPUT);
  pinMode(stepZ, OUTPUT);
  pinMode(dirZ, OUTPUT);
  pinMode(enablePin, OUTPUT);

  digitalWrite(enablePin, LOW); // Enable motor drivers
  Serial.println("3-Axis Laser Micro-Patterning Stage Initialized.");
}

void stepMotor(int stepPin, int steps, int stepDelayMicros) {
  for (int i = 0; i < steps; i++) {
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(stepDelayMicros);
    digitalWrite(stepPin, LOW);
    delayMicroseconds(stepDelayMicros);
  }
}

// Perform continuous serpentine raster ablation scan
void rasterScan(float width_mm, float height_mm, float pitch_mm, int speedDelay) {
  int x_steps = width_mm * STEPS_PER_MM_X;
  int y_step_pitch = pitch_mm * STEPS_PER_MM_Y;
  int lines = height_mm / pitch_mm;

  Serial.println("Starting Laser Raster Micro-Patterning...");
  bool direction = true;

  for (int i = 0; i < lines; i++) {
    digitalWrite(dirX, direction ? HIGH : LOW);
    stepMotor(stepX, x_steps, speedDelay);

    // Step Y forward by line pitch
    digitalWrite(dirY, HIGH);
    stepMotor(stepY, y_step_pitch, speedDelay);

    direction = !direction; // Alternate scan direction
  }
  Serial.println("Raster Scan Complete.");
}

void loop() {
  if (Serial.available() > 0) {
    char cmd = Serial.read();
    if (cmd == 'R') {
      rasterScan(5.0, 5.0, 0.05, 800); // 5mm x 5mm, 50 um pitch
    }
  }
}
