int multiplier = 500;

// x goes from [-2; 0.47]
float mandelbrot_x_start = -2;
float mandelbrot_x_end = 0.47;

float mandelbrot_x_length = mandelbrot_x_end - mandelbrot_x_start;

int screen_width = int(mandelbrot_x_length * multiplier);

// y goes from [-1.12; 1.12]
float mandelbrot_y_start = -1.12;
float mandelbrot_y_end = 1.12;

float mandelbrot_y_length = mandelbrot_y_end - mandelbrot_y_start;

int screen_height = int(mandelbrot_y_length * multiplier);

// if it passes over 255, it starts becoming uglier
int max_iteration = 250;
int max_iteration_step = 10;

int max_color = 220;

color grey = color(128, 128, 128);
color black = color(0, 0, 0);

color[] create_palette(int max_iteration) {

  color[] to_return = new color[max_iteration];

  float step_size = float(max_color)/max_iteration;
  println("Step size: " + step_size);

  for (int i=0; i < max_iteration; i++) {
    float current = i*step_size;

    current = max_color - current;

    to_return[i] = color(current, current, current);
  }

  println("First palette color: " + hex(to_return[0]));
  println("Last palette color (" + max_iteration + "): " + hex(to_return[max_iteration - 1]));

  return to_return;
}

color[] palette = create_palette(max_iteration);

float scale_x_screen_coordinate(int pixel_x_coord) {
  return mandelbrot_x_start + (pixel_x_coord * mandelbrot_x_length)/screen_width;
}

float scale_y_screen_coordinate(int pixel_y_coord) {
  return mandelbrot_y_start + (pixel_y_coord * mandelbrot_y_length)/screen_width;
}

void mandelbrot(int current_max_iteration) {
  println("Mandelbrot with max_iteration: " + current_max_iteration);

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      // scaled x coordinate of pixel (on the Mandelbrot X scale)
      float x0 = scale_x_screen_coordinate(i);

      // scaled y coordinate of piyel (on the Mandelbrot y scale)
      float y0 = scale_y_screen_coordinate(j);

      float x = 0;
      float y = 0;

      int iteration = 0;

      while((x*x + y*y <= 2*2) && (iteration < current_max_iteration)) {
        float x_temp = x*x - y*y + x0;
        y = 2*x*y + y0;
        x = x_temp;

        iteration = iteration + 1;
      }

      color c = palette[iteration - 1];

      set(i, j, c);
    }
  }
}

// Processing standard functions

void settings() {
  size(screen_width, screen_height);
}

void setup() {
  background(grey);
}

int current_max_iteration = max_iteration_step;

void draw() {
  mandelbrot(current_max_iteration);

  if(current_max_iteration >= max_iteration) {
    noLoop();
  }

  current_max_iteration = current_max_iteration + max_iteration_step;
}
