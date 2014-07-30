package treehouse.crystalball;

import treehouse.crystalball.ShakeDetector.OnShakeListener;
import android.app.Activity;
import android.graphics.drawable.AnimationDrawable;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.media.MediaPlayer;
import android.media.MediaPlayer.OnCompletionListener;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.animation.AlphaAnimation;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends Activity 
{
	private CrystalBall cb = new CrystalBall();
	private TextView answerLabel;
	private SensorManager sensorManager;
	private Sensor accelerometer;
	private ShakeDetector shakeDetector;
	private ImageView crystalBallImage;
	
	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		sensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
		accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
		shakeDetector = new ShakeDetector(new OnShakeListener() {
			@Override
			public void onShake() { handleNewAnswer(); }
		});	
	}
	
	@Override
	public void onResume()
	{
		super.onResume();
		sensorManager.registerListener(shakeDetector, accelerometer, SensorManager.SENSOR_DELAY_UI);
	}
	
	@Override
	public void onPause()
	{
		super.onPause();
		sensorManager.unregisterListener(shakeDetector);
	}
	
	
	private void animateCrystalBall()
	{
		crystalBallImage = (ImageView) findViewById(R.id.imageView1);
		crystalBallImage.setImageResource(R.drawable.ball_animation);
		AnimationDrawable ballAnimation = (AnimationDrawable) crystalBallImage.getDrawable();
		if(ballAnimation.isRunning()) { ballAnimation.stop(); }
		ballAnimation.start();
	}
	
	private void animateAnswer()
	{
		AlphaAnimation fadeInAnimation = new AlphaAnimation(0, 1);
		fadeInAnimation.setDuration(1500);
		fadeInAnimation.setFillAfter(true);
		answerLabel = (TextView) findViewById(R.id.textView1);
		answerLabel.setAnimation(fadeInAnimation);
	}
	
	private void playSound()
	{
		MediaPlayer player = MediaPlayer.create(this, R.raw.crystal_ball);
		player.start();
		player.setOnCompletionListener(new OnCompletionListener()
		{
			public void onCompletion(MediaPlayer mp)
			{
				mp.release();
			}
		});
	}
	

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) 
	{
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) 
		{
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	private void handleNewAnswer() {
		//Update the label with our dynamic answer
		answerLabel = (TextView) findViewById(R.id.textView1);
		answerLabel.setText(cb.getAnAnswer());
		animateCrystalBall();
		animateAnswer();
		playSound();
	}
}
