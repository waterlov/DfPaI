
# Week 1

Do the exercises in:
* BouncingBalls
* gradient
* Grid

## What's printed and why?

### A

```processing

int a = 2;

void go() {
  a++;
}

void setup() {
  println(a);
}

```
answer : 3 - go function changed the vaule of global variable a;

### B

```processing
int x = 0;

void go(int x) {
  x++;
}

void setup() {
  println(x);
}
```
answer : 0 - go funciton changed the value of argument variable x(not global variable x);

### C

```processing
class Thing {
  int a;
}

void go(Thing t) {
  t.a++;
}

void setup() {
  Thing thing = new Thing();
  thing.a = 2;
  
  go(thing);

  println(thing.a);
}
```
*put your answer here*
answer : 3 - go funciton approached the variable a in object(thing) and changed the variable a of the object(thing);
