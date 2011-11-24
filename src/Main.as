package 
{
	//import be.nascom.flash.graphics.Rippler;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.display.BitmapDataChannel;
	import flash.filters.BlurFilter;
	import flash.filters.BevelFilter;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.filters.GradientBevelFilter;
	import flash.filters.GradientGlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.display.BlendMode;
	
	/**
	 * ...
	 * @author Arya
	 */
	public class Main extends Sprite 
	{
		//[Embed(source = 'snake.jpg')]
		private var Python:Class;
		private var bg:Bitmap;
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var surface_top:BallSurface;
		private var surface_bottom:BallSurface;
		private var bitmap:Bitmap;
		private var bmp:BitmapData;
		private var bmpblur:BitmapData;
		private var fps:TextField;
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//bg = new Python();
			
			//addChild(bg);
			
			surface_top = new BallSurface();
			surface_top.visible = false;
			
			surface_top.x += 0;
			
			
			var filt:ColorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 255, 255);
			var filts:Array = new Array(filt);		
			//surface_top.transform.colorTransform = filt;
			
			trace(stage.width);
			
			bmp = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0);
			bmpblur = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0);
			
			
			bitmap = new Bitmap(bmp);
			

			
			//bitmap.filters = filts;
			
			
			addChild(surface_top);	
			addChild(bitmap);
			
			fps = new TextField();
			addChild(fps);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//ripple = new Rippler(bitmap, 3, 2);
		}
		
	//	private var ripple:Rippler;
		
		private function onEnterFrame(e:Event):void {
			//fps.text = stage.frameRate.toString();
			
			bmp.fillRect(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), 0);
			
			
			//var bmpblur:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0);
			bmpblur.fillRect(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), 0);
			
			var bgColor:uint     = 0xCCCCCC;
			var size:uint        = 5;
			var offset:uint      = 30;
			var distance:Number  = 4;
			var angleInDegrees:Number = 135; // opposite 45 degrees
			//var colors:Array     = [0xFFFFFF, 0xffc000, 0x000000];
			//var alphas:Array     = [0.6, 0.3, 0.8];
			//var ratios:Array     = [0, 128, 255];
			var colors:Array     = [0x000000, 0x000000, 0xFFFFFF];
			var alphas:Array     = [0.9, 0.0, 0.0];
			var ratios:Array     = [0, 120, 255];
			var blurX:Number     = 8;
			var blurY:Number     = 8;
			var strength:Number  = 1;
			var quality:Number   = BitmapFilterQuality.HIGH;
			var type:String      = BitmapFilterType.INNER;
			var knockout:Boolean = false;
			
			var zero:Point = new Point(0, 0);
			
			
			var bevel:GradientBevelFilter = new GradientBevelFilter(distance, angleInDegrees, colors, alphas, ratios, blurX, blurY, strength, quality, type, knockout);
			
			distance  = 4;
			angleInDegrees = 45;
			//colors   = [0x222200, 0x222200, 0xffff66, 0x445000];
			//alphas     = [0.1, 0.1, 0.75, 0.6];			
			// warna-warni
			//colors   = [0xFFFFFF, 0xFF0000, 0xccFF00, 0x00CCFF];
			//alphas     = [0, 0.2, 1, 1];
			//ratios     = [0, 10, 120, 255];
			colors   = [0x666633, 0xCC9933, 0xffff66, 0xCC9933];
			alphas     = [0.2, 0.2, 1, 1];
			ratios     = [0, 5, 120, 255];
			blurX     = 20;
			blurY     = 20;
			strength  = 0.5;
			quality   = BitmapFilterQuality.HIGH;
			type     = BitmapFilterType.INNER;
			knockout = false;
			
			var glow:GradientGlowFilter = new GradientGlowFilter(distance, angleInDegrees, colors, alphas, ratios, blurX, blurY, strength, quality, type, knockout);
			
			surface_top.balls.forEach(function(item:Ball, index:int, vector:Vector.<Ball>):void {
				//bmp.draw(item);
			});
			
			bmp.draw(surface_top);
			
			var bgbmp:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0);
			//bgbmp.draw(bg, null, null, BlendMode.NORMAL);
			bgbmp.draw(bmp, null, null, BlendMode.ALPHA, null, false);
			
			
			
			//bmpblur.draw(bgbmp);
			
			//bmp.colorTransform(bmp.rect, new ColorTransform(1, 1, 1, 1, 0, 0, 0, -50));
			//bgbmp.perlinNoise(30, 30, 2, 2011, true, true, 7, true);
			//bgbmp.copyChannel(bmp, bmp.rect, zero, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			

			
			bmpblur.draw(bmp);
			
			
			
			var matrix:Array = new Array();
			matrix = matrix.concat([1, 0, 0, 0, 0xff]); // red
            matrix = matrix.concat([0, 1, 0, 0, 0xc0]); // green
            matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 0.8, 0]); // alpha			
			
			//bmpblur.applyFilter(bmpblur, bmpblur.rect, zero, new ColorMatrixFilter(matrix));
			bmpblur.applyFilter(bmpblur, bmpblur.rect, zero, glow);
			bmpblur.applyFilter(bmpblur, bmpblur.rect, zero, bevel);//new BevelFilter(2, 45, 0xffffff, 0.25, 0, 0.3, 7, 7, 8, 3));// BlurFilter(20, 20, 2));
			//bmpblur.applyFilter(bmp, bmp.rect, new Point(0, 0), new BlurFilter(1, 1, 1));
			
			bitmap.bitmapData = bmpblur;
			trace(surface_top.balls[1].x);
			
			//ripple.drawRipple(surface_top.balls[1].x, surface_top.balls[1].y, 1, 255);
			

			
		}

	}
	
}