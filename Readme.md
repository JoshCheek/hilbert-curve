Hilbert Curve
=============

Hilbert cube

![Hilbert Cube](images/cube.png)

Dragon curve

![Square curve](images/dragon.png)

Without spacing between, using it to choose colours

![all of them](images/hilbert.png)

Watch it draw

![watch it draw](images/hilbert.gif)

Watch it draw again, this one looks more like a Hilbert curve b/c I spaced the vertices.

![watch it draw 2](images/hilbert3.gif)

32 Segment curve

![32 segment curve](images/32-segment-curve.gif)

Square curve

![Square curve](images/square1.png)

![Square curve](images/square2.png)

Resources
---------

* Paper on 3d Hilbert curves [http://arxiv.org/pdf/1109.2323v1.pdf](http://arxiv.org/pdf/1109.2323v1.pdf)
* Representing a 3d Hilbert curve as an Lsystem [http://math.stackexchange.com/questions/123642/representing-a-3d-hilbert-curve-as-an-l-system](http://math.stackexchange.com/questions/123642/representing-a-3d-hilbert-curve-as-an-l-system)
  This is the definition I actually used

  ```javascript
  lsystem Hilbert3D {

      set iterations = 3;
      set symbols axiom = X;

      interpret F as DrawForward(10);
      interpret + as Yaw(90);
      interpret - as Yaw(-90);
      interpret ^ as Pitch(90);
      interpret & as Pitch(-90);
      interpret > as Roll(90);
      interpret < as Roll(-90);
      rewrite X to ^ < X F ^ < X F X - F ^ > > X F X & F + > > X F X - F > X - >;
  }
  ```
* Hilbert curves you can draw [https://bentrubewriter.wordpress.com/2012/04/26/fractals-you-can-draw-the-hilbert-curve-or-what-the-labyrinth-really-looked-like/](https://bentrubewriter.wordpress.com/2012/04/26/fractals-you-can-draw-the-hilbert-curve-or-what-the-labyrinth-really-looked-like/)
  Provides Lsystems for a number of different 2d curves:
  * Hilbert
    - Axiom: A
    - A -> - B F + A F A + F B -
    - B -> + A F - B F B - F A +
  * Sierpinski Triangle
    - Axiom A
    - A -> B-A-B
    - B -> A+B+A
    - In this case we rotate 60 degrees with every turn, and A and B are both used to mean draw a line forward
  * Koch Curve
    - Axiom F++F++F
    - F -> F-F++F-F
    - Use 60 degree turns
  * Dragon Curve L-System:
    - Axiom: FX
    - X -> X+YF
    - Y -> FX-Y
    - Use 90 degree turns
  * Quadratic Fractal:
    - Axiom: F+F+F+F
    - F -> F+F-F
    - Use 90 degree turns
  * Koch Curve Variant:
    - Axiom = F
    - F -> F+F-F-F+F
    - Use 90 degree turns
  * Fractal Plant:
    - Axiom: X
    - X -> F-[[X]+X]+F[+FX]-X
    - F -> FF
    - Use 25 degree turns. When you encounter a ‘[‘ save the current angle and position
      and restore when you see ‘]’. This is an example of a recursive L-System.
* A bunch of 2d curves, plus some code for Hilbert in Mathematmica [http://mathforum.org/advanced/robertd/lsys2d.html](http://mathforum.org/advanced/robertd/lsys2d.html)
  - Koch curve (F -> F+F--F+F, 60°):
  - 32-segment curve (F -> -F+F-F-F+F+FF-F+F+FF+F-F-FF+FF-FF+F+F-FF-F-F+FF-F-F+F+F-F+)
  - Hilbert curve (L -> +RF-LFL-FR+, R -> -LF+RFR+FL-)
  - Arrowhead curve (X -> YF+XF+Y, Y -> XF-YF-X, 60°)
  - Dragon curve (X -> X+YF+, Y -> -FX-Y)
  - Hilbert curve II (X -> XFYFX+F+YFXFY-F-XFYFX, Y -> YFXFY-F-XFYFX+F+YFXFY)
  - Peano-Gosper curve (X -> X+YF++YF-FX--FXFX-YF+, Y -> -FX+YFYF++YF+FX--FX-Y, 60°)
  - Peano curve (F -> F+F-F-F-F+F+F+F-F)
  - Quadratic Koch island (F -> F-F+F+FFF-F-F+F)
  - Square curve (X -> XF-F+F-XF+F+XF-F+F-X)
  - Sierpinski triangle (F -> FF, X -> --FXF++FXF++FXF--, 60°)
* The algorithmic beauty of plants [http://algorithmicbotany.org/papers/#abop](http://algorithmicbotany.org/papers/#abop)
* Someone's 3d Hilbert curve for Processing [http://martinpblogformasswritingproject.blogspot.com/2011/06/3d-hilbert-fractal-in-pyprocessing.html](http://martinpblogformasswritingproject.blogspot.com/2011/06/3d-hilbert-fractal-in-pyprocessing.html)
* Someone's 3d Hilbert curve for Mathematica [http://robertdickau.com/lsys3d.html](http://robertdickau.com/lsys3d.html)
* Some nice 2d Hilbert curve results [https://lustrebox.wordpress.com/2012/06/17/fractals/](https://lustrebox.wordpress.com/2012/06/17/fractals/)

License
-------

[Just do what the fuck you want to](http://www.wtfpl.net/about/)
