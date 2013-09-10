package;

import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxTilemap;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxObject;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.util.FlxMath;
import org.flixel.util.FlxPoint;
import org.flixel.util.FlxRect;

class MenuState extends FlxState
{
	private var background:FlxSprite;
	private var player:FlxSprite;
	private var collision:FlxTilemap;
	private var mouseLocation:Int;
	
	override public function create():Void
	{
		// Set a background color
		FlxG.bgColor = 0xff131c1b;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		collision = new FlxTilemap();
		collision.loadMap(Assets.getText("assets/collision.txt"), "assets/tiles.png",128,76);
		add(collision);
		
		
		background = new FlxSprite();
		background.loadGraphic("assets/environment.png", false, false, 2048, 760);
		FlxG.worldBounds = new FlxRect(0, 0, background.width, background.height);
		add(background);
		
		
		
		player = new FlxSprite();
		player.loadGraphic("assets/player.png", true, true, 130, 282);
		add(player);
		player.x = 300;
		player.y = 400;
		
		
		FlxG.camera.follow(player);
		FlxG.camera.bounds = new FlxRect(0, 0, background.width, background.height);
		
		super.create();
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		
		FlxG.collide(collision, player);
		
		if (FlxG.keys.LEFT) {
			player.velocity.x = -200;
		}
		if (FlxG.keys.RIGHT){
			player.velocity.x = 200;
		}
		
		if (FlxG.keys.UP){
			player.velocity.y = -200;
		}
		
		if (FlxG.keys.DOWN){
			player.velocity.y = 200;
		}
		
		//On mouse click
		if (FlxG.mouse.pressed())
		{
			player.followPath(collision.findPath(new FlxPoint(player.x, player.y), FlxG.mouse.getScreenPosition()), 100);
		}
		
		
	}	
}