package treehouse.crystalball;

import java.util.Random;

public class CrystalBall 
{
	private Random rng;
	private String [] answers = 
	{
			"Yes", "No", "Ask Again Later",
			"I Don't Know", "Ask Yourself",
			"I'm A Platypus", "Moo", "Oui?",
			"Not Gonna Happen", "Um....Okay Then",
			"David Bowie!"
	};
	
	public CrystalBall()
	{	
		rng = new Random();
	}
	
	public String getAnAnswer()
	{
		int randomNumber = rng.nextInt(answers.length);
		return answers[randomNumber];
	}
	
}
