package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Arya
	 */
	public class BallSurface extends Sprite 
	{
				
		private var surface_top:BallSurface;
		private var prevmouse:Point;
		public var balls:Vector.<Ball>;

		
		public function BallSurface() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			prevmouse = new Point(stage.mouseX, stage.mouseY);
			
			balls = new Vector.<Ball>();
			var i:Number;
			
			for (i = 0; i < 100; i++) {
				var ball:Ball = new Ball();
				var spread:Number = 100;
				ball.x = stage.stageWidth / 2 - 20 + Math.random() * 40;
				ball.y = stage.stageHeight / 2 - 20 + Math.random() * 40;
				ball.follow.x = stage.mouseX  - spread/2 + Math.random() * spread;
				ball.follow.y = stage.mouseY  - spread/2 + Math.random() * spread;
				
				balls.push(ball);
				addChild(ball);
			}
			
			trace("goat");
			
			trace(prevmouse.x + " " + prevmouse.y);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		
		private function onMouseMove(e:MouseEvent):void {
			trace("mouse: " + mouseX + " " + mouseY);
			var spread:Number = 120;
			balls.forEach(function(item:Ball, index:int, vector:Vector.<Ball>):void {
				item.follow.x = stage.mouseX - spread / 2 + Math.random() * spread;
				item.follow.y = stage.mouseY - spread / 2 + Math.random() * spread;
				
				//item.follow.x += stage.mouseX - prevmouse.x;// - spread / 2 + Math.random() * spread;
				//item.follow.y += stage.mouseY - prevmouse.y;// - spread / 2 + Math.random() * spread;
				
			});
				prevmouse.x = stage.mouseX;
				prevmouse.y = stage.mouseY;
		}
		
		private function onEnterFrame(e:Event):void {
			
		}

	}

}