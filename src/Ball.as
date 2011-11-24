package  
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Arya
	 */
	public class Ball extends Sprite 
	{
		public var follow:Point;
		private var spd:TextField;
		private static var spread:Number = 40;
		private var rad:Number;
		
		public function Ball() 
		{
			super();
			rad = Math.random() * 20;
			this.graphics.beginFill(0xffc000);//0xcacaca);//0xffd000);
			this.graphics.drawCircle(0,0,rad);
			this.graphics.endFill();
			follow = new Point();
			spd = new TextField();
			spd.text = "0";
			//addChild(spd);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private var SPEED:Number;
		private var distance:Number;
		
		private function onEnterFrame(e:Event):void {
			
			distance = Math.pow(Math.pow(follow.y - this.y, 2) + Math.pow(follow.x - this.x, 2), 0.5);
			SPEED = 1 / Math.pow(distance / 10, 0.5) * 1000 * (0.2 + Math.random() * 0.8) + rad * 2;
			//spd.text = distance.toPrecision(3);//
			spd.text = SPEED.toPrecision(3);

			if (Math.abs(follow.x - this.x) > spread) {
				this.x += (follow.x - this.x) /Math.sqrt(Math.pow(follow.y - this.y, 2)+Math.pow(follow.x - this.x, 2)) * SPEED/ stage.frameRate;
			} else {
				//this.x = follow.x - 10 + Math.random() * 20;
				//this.x = this.x - 1 + Math.random() * 2;
			}
			if (Math.abs(follow.y - this.y) > spread) {
				this.y += (follow.y - this.y) / Math.sqrt(Math.pow(follow.y - this.y, 2) + Math.pow(follow.x - this.x, 2)) * SPEED/ stage.frameRate;
			} else {
				//this.y = this.y - 1 + Math.random() * 2;
			}
		}
		
		
	}

}