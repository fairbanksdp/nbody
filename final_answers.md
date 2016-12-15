# nbody Working

## Final Questions

Answer the following questions in a file named `final_answers.md` in your nbody repo.

1. Compare your simulation file loading code to the working version. Differences and similarities?
Similarities: both implementations take the form of a method in a class, reads the simulation based on the number of bodies, use the ARGV input.
Differences: answer converts input to array on loading the file where as mine waits until sorting the info by line to do so, loaded info string is passed directly to body class.
2. Compare your Body (or Planet - whatever you called it) to the working version. Differences and similarities?
Similarities: The physics calculations are the same. 
Differences: my calculations are all done in the update method instead of their own methods, I made a vector class for the vector calculation, scaling for drawing takes place in the body class.
3. What are the advantages of having a separate Universe class? Disadvantages?
Advantages: keeps both the nbody class and univers class clean and easier to read.
Disadvantages: adds a level of complexity, makes it harder to program a termanal to interact with simulation while its running.
4. Identify some other interesting difference between your version and mine. Which approach do you prefer and why?
My version implements a termanal to change simulation variables without changing the source code.
Your version is much cleaner and easier to read.  It uses some techniques that I did not know/ did not think of to remove unnecessary lines.
5. What are your coding strengths? Weaknesses?
Strengths: my code is reletively clean and easy to debug.
Weaknesses: commenting, not extreamly effitiant.
