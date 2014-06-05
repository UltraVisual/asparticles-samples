package;


import uk.co.ultravisual.asparticles.ASParticleSystem;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.geom.Point;

class Sample extends Sprite {
    var particleSystem:ASParticleSystem;

    var systems:Array<String>;
    var currIndex:Int;

    public function new() {
        super();

        currIndex = 0;
        systems = new Array();
        systems.push("comet.plist");
        systems.push('crazy.plist');
        systems.push("electrons.plist");
        systems.push('galaxy.plist');
        systems.push('airStars.plist');
        systems.push('boil.plist');
        systems.push('emit.plist');
        systems.push('fire.plist');
        systems.push('fireForest.plist');
        systems.push('Firework.plist');
        systems.push('pinkStream.plist');
        systems.push('pop.plist');
        systems.push('space.plist');
        systems.push('starLines.plist');
        systems.push('tourni.plist');
        systems.push('waterfall.plist');


        init();

        addEventListener(Event.ADDED_TO_STAGE, addToStage);
    }

    private function init() {
        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
        Lib.current.stage.addEventListener(Event.ACTIVATE, stage_onActivate);
        Lib.current.stage.addEventListener(Event.DEACTIVATE, stage_onDeactivate);

        var bk:Sprite = new Sprite();
        bk.graphics.beginFill(0x000000);
        bk.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        bk.graphics.endFill();
        addChild(bk);

        /**
        *   Be sure to put in trailing "/"" for assets path (2nd argument)
        **/

        particleSystem = ASParticleSystem.particleWithFile("galaxy.plist", "assets/particles/");
        addChild(particleSystem);

        addEventListener(MouseEvent.MOUSE_MOVE, mMove);
        addEventListener(MouseEvent.CLICK, firework);
    }

    public function addToStage(evt:KeyboardEvent) {
        removeEventListener(Event.ADDED_TO_STAGE, addToStage);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, switchParticles);
    }

    public function switchParticles(key:KeyboardEvent) {
        trace("Keydown - " + currIndex);

        if (particleSystem != null) {
            removeChild(particleSystem);
            particleSystem.destroy();
            particleSystem = null;
        }

        currIndex++;
        if (currIndex >= systems.length)
            currIndex = 0;

        var psystem:String = systems[currIndex];

        particleSystem = ASParticleSystem.particleWithFile(psystem, "assets/particles/");
        addChild(particleSystem);
    }

    public function mMove(evt:MouseEvent) {
        if (particleSystem != null)
            particleSystem.position = new Point(mouseX, mouseY);
    }

    public function firework(evt:MouseEvent) {
        var ps = ASParticleSystem.particleWithFile(systems[currIndex], "assets/particles/");

        ps.position = new Point(mouseX, mouseY);
        addChild(ps);
    }

    private function stage_onActivate(event:Event):Void {
        trace("stage_onActivate");
    }


    private function stage_onDeactivate(event:Event):Void {
        trace("stage_onDeactivate");

    }

    public static function main() {
        Lib.current.addChild(new Sample());
    }
}