#import "stdio.h"

typedef struct {
  int occupied;
  int dx;
  int dy;
  int dz;
} Status;

typedef struct {
  int x;
  int y;
  int z;
} Location;

typedef struct {
  Status cells[6][6][6];
  Location current;
  int path_length;
} Cube;


void print_cube(Cube cube) {
  Location cursor = {
    cube.current.x,
    cube.current.y,
    cube.current.z
  };
  Status status;

  while(cursor.x!=-1) {
    status = cube.cells[cursor.x][cursor.y][cursor.z];
    printf("(%d,%d,%d)",
           cursor.x, cursor.y, cursor.z
           /* (status.occupied ? "occupied" : "available"), */
           /* status.dx, status.dy, status.dz */
    );

    cursor.x += status.dx;
    cursor.y += status.dy;
    cursor.z += status.dz;
  };

  printf("\n");
  printf("------------------");
}

int TOTAL_SEEN = 0;

void print_status(Cube cube, int num_found) {
  printf("SEEN: %d FOUND %d\n", TOTAL_SEEN, num_found);
  print_cube(cube);
}


int fill(Cube cube, int found) {
  /* if(++TOTAL_SEEN % 10000 == 0) */
  /*   print_status(cube, found); */

  if(216 == cube.path_length) {
    print_status(cube, found);
    return ++found;
  }

  Location current = cube.current;

  Location adjacent[] = {
    {current.x-1, current.y  , current.z  },
    {current.x+1, current.y  , current.z  },
    {current.x  , current.y-1, current.z  },
    {current.x  , current.y+1, current.z  },
    {current.x  , current.y  , current.z-1},
    {current.x  , current.y  , current.z+1},
  };

  for(int i=0; i<6; ++i) {
    Location loc    = adjacent[i];
    Status   status = cube.cells[loc.x][loc.y][loc.z];
    if( loc.x < 0 || loc.x > 5 ||
        loc.y < 0 || loc.y > 5 ||
        loc.z < 0 || loc.z > 5 ||
        status.occupied
      ) continue;
    int old_x = cube.current.x;
    int old_y = cube.current.y;
    int old_z = cube.current.z;
    cube.path_length++;
    status.occupied = 1;
    status.dx       = loc.x - current.x;
    status.dy       = loc.y - current.y;
    status.dz       = loc.z - current.z;
    cube.current.x  = loc.x;
    cube.current.y  = loc.y;
    cube.current.z  = loc.z;
    found           = fill(cube, found);
    cube.current.x  = old_x;
    cube.current.y  = old_y;
    cube.current.z  = old_z;
    status.occupied = 0;
    cube.path_length--;
  }

  return found;
}

int main(int argc, char**argv) {
  Cube cube                    = {};
  cube.path_length             = 1;
  cube.cells[0][0][0].occupied = 1;
  cube.cells[0][0][0].dx       = -1;
  cube.cells[0][0][0].dy       = -1;
  cube.cells[0][0][0].dz       = -1;
  cube.current.x               = 0;
  cube.current.y               = 0;
  cube.current.z               = 0;

  fill(cube, 0);
  return 0;
}
