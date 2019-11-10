float t;
static final int WIDTH = 1000;
static final int HEIGHT = 1000;
static final int NUM_LINES = 20;

void setup() {
  background(20);
  size(1000, 1000);
}

static float blue_background = 120;

void draw() {

  blue_background = random_color(blue_background, 10, 255);

  background(
      255,
      200,
      blue_background
  );

  strokeWeight(3);

  translate(width/2, height/2);

  float red_stroke = random_color(20, 10, 255);
  stroke(red_stroke, 100, 100);

  for (int i = 0; i < NUM_LINES; i++) {
    line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));
  }
  t+= 0.1;
}

float random_color(float base, float amplitude, int max) {
  return (base + noise(t)*sin(t)*amplitude) % max;
}

float x1(float t) {
  return (sin(t / 10) * (t % WIDTH) + cos(t / 5) * (t % (0.75 * WIDTH))) % WIDTH;
}

float y1(float t) {
  return (sin(t / 2) * (t % (0.8*HEIGHT)) - cos(t / 15) * (t % HEIGHT)) % HEIGHT;
}

float x2(float t) {
  return (sin(-t / 10) * (t % WIDTH) + cos(-t / 5) * (t % (0.75 * WIDTH))) % WIDTH;
}

float y2(float t) {
  return (sin(-t / 2) * (t % (0.8*HEIGHT)) - cos(-t / 15) * (t % HEIGHT)) % HEIGHT;
}
