import com.stencyl.Engine;
import com.stencyl.models.Actor;
import com.stencyl.behavior.Script;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.joints.B2Joint;
import box2D.dynamics.joints.B2DistanceJoint;
import box2D.dynamics.joints.B2DistanceJointDef;
import box2D.dynamics.joints.B2GearJoint;
import box2D.dynamics.joints.B2GearJointDef;
import box2D.dynamics.joints.B2LineJoint;
import box2D.dynamics.joints.B2LineJointDef;
import box2D.dynamics.joints.B2PrismaticJoint;
import box2D.dynamics.joints.B2PrismaticJointDef;
import box2D.dynamics.joints.B2PulleyJoint;
import box2D.dynamics.joints.B2PulleyJointDef;
import box2D.dynamics.joints.B2MouseJoint;
import box2D.dynamics.joints.B2MouseJointDef;
import box2D.dynamics.joints.B2RevoluteJoint;
import box2D.dynamics.joints.B2RevoluteJointDef;
import box2D.dynamics.joints.B2WeldJoint;
import box2D.dynamics.joints.B2WeldJointDef;

class Joints
{
	// ==== mouse joints ==== // 
	
	public static function createMouseJoint(actor:Actor)
	{
		if (actor != null)
		{
			var jointDef:B2MouseJointDef = new B2MouseJointDef();
			jointDef.bodyA = Engine.engine.world.getGroundBody();
			jointDef.bodyB = actor.getBody();
			jointDef.target = actor.getBody().getWorldCenter();
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	public static function toVec(x:Float, y:Float):B2Vec2
	{
		return new B2Vec2(Engine.toPhysicalUnits(x), Engine.toPhysicalUnits(y));
	}
	
	// ==== distance joints ==== // 
	
	public static function createDistanceJoint(actor1:Actor, x1:Float, y1:Float, actor2:Actor, x2:Float, y2:Float)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = (actor2 == null)? Engine.engine.world.getGroundBody() : actor2.getBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x2), Engine.toPhysicalUnits(y2));
			
			var jointDef:B2DistanceJointDef = new B2DistanceJointDef();
			jointDef.initialize(body1, body2, body1.getWorldPoint(anchor1), body2.getWorldPoint(anchor2));
			jointDef.localAnchorA = anchor1;
			jointDef.localAnchorB = anchor2;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	// ==== line joints ==== // 
	
	public static function createLineJoint(actor1:Actor, x1:Float, y1:Float, axisX:Float, axisY:Float)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = Engine.engine.world.getGroundBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = body2.getLocalPoint(body1.getWorldPoint(anchor1));
			var axis:B2Vec2 = new B2Vec2(axisX, axisY);
			
			var jointDef:B2LineJointDef = new B2LineJointDef();
			jointDef.initialize(body2, body1, anchor1, axis);
			jointDef.localAnchorA = anchor2;
			jointDef.localAnchorB = anchor1;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	// ==== prismatic joints ==== // 
	
	public static function createPrismaticJoint(actor1:Actor, x1:Float, y1:Float, axisX:Float, axisY:Float)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = Engine.engine.world.getGroundBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = body2.getLocalPoint(body1.getWorldPoint(anchor1));
			var axis:B2Vec2 = new B2Vec2(axisX, axisY);
			
			var jointDef:B2PrismaticJointDef = new B2PrismaticJointDef();
			jointDef.initialize(body2, body1, anchor1, axis);
			jointDef.localAnchorA = anchor2;
			jointDef.localAnchorB = anchor1;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	// ==== revolute joints ==== // 
	
	public static function createRevoluteJointAtOverlap(actor1:Actor, x1:Float, y1:Float, actor2:Actor)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = (actor2 == null)? Engine.engine.world.getGroundBody() : actor2.getBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = body2.getLocalPoint(body1.getWorldPoint(anchor1));
			
			var jointDef:B2RevoluteJointDef = new B2RevoluteJointDef();
			jointDef.initialize(body2, body1, anchor2);
			jointDef.localAnchorA = anchor2;
			jointDef.localAnchorB = anchor1;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	public static function createRevoluteJoint(actor1:Actor, x1:Float, y1:Float, actor2:Actor, x2:Float, y2:Float)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = (actor2 == null)? Engine.engine.world.getGroundBody() : actor2.getBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x2), Engine.toPhysicalUnits(y2));
			
			var jointDef:B2RevoluteJointDef = new B2RevoluteJointDef();
			jointDef.initialize(body2, body1, anchor2);
			jointDef.localAnchorA = anchor2;
			jointDef.localAnchorB = anchor1;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	// ==== weld joints ==== // 
	
	public static function createWeldJointAtOverlap(actor1:Actor, x1:Float, y1:Float, actor2:Actor)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = (actor2 == null)? Engine.engine.world.getGroundBody() : actor2.getBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = body2.getLocalPoint(body1.getWorldPoint(anchor1));
			
			var jointDef:B2WeldJointDef = new B2WeldJointDef();
			jointDef.initialize(body1, body2, anchor1);
			jointDef.localAnchorA = anchor1;
			jointDef.localAnchorB = anchor2;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	public static function createWeldJoint(actor1:Actor, x1:Float, y1:Float, actor2:Actor, x2:Float, y2:Float)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = (actor2 == null)? Engine.engine.world.getGroundBody() : actor2.getBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x2), Engine.toPhysicalUnits(y2));
			
			var jointDef:B2WeldJointDef = new B2WeldJointDef();
			jointDef.initialize(body1, body2, anchor1);
			jointDef.localAnchorA = anchor1;
			jointDef.localAnchorB = anchor2;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	public static function createStationaryWeldJoint(actor1:Actor)
	{
		if (actor1 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = Engine.engine.world.getGroundBody();
			var anchor1:B2Vec2 = body1.getLocalCenter();
			var anchor2:B2Vec2 = body2.getLocalPoint(body1.getWorldPoint(anchor1));
			
			var jointDef:B2WeldJointDef = new B2WeldJointDef();
			jointDef.initialize(body1, body2, anchor1);
			jointDef.localAnchorA = anchor1;
			jointDef.localAnchorB = anchor2;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	// ==== pulley joints ==== // 
	
	public static function createPulleyJoint(actor1:Actor, x1:Float, y1:Float, actor2:Actor, x2:Float, y2:Float, gx1:Float, gy1:Float, gx2:Float, gy2:Float, ratio:Float)
	{
		if (actor1 != null && actor2 != null)
		{
			var body1:B2Body = actor1.getBody();
			var body2:B2Body = (actor2 == null)? Engine.engine.world.getGroundBody() : actor2.getBody();
			var anchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x1), Engine.toPhysicalUnits(y1));
			var anchor2:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(x2), Engine.toPhysicalUnits(y2));
			var groundAnchor1:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(gx1), Engine.toPhysicalUnits(gy1));
			var groundAnchor2:B2Vec2 = new B2Vec2(Engine.toPhysicalUnits(gx2), Engine.toPhysicalUnits(gy2));
			
			var jointDef:B2PulleyJointDef = new B2PulleyJointDef();
			jointDef.initialize(body1, body2, groundAnchor1, groundAnchor2, body1.getWorldPoint(anchor1), body2.getWorldPoint(anchor2), ratio);
			jointDef.localAnchorA = anchor1;
			jointDef.localAnchorB = anchor2;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}
	
	// ==== gear joints ==== // 
	
	/*public static function createGearJoint(joint1:B2Joint, joint2:B2Joint, ratio:Float)
	{
		if (joint1 != null && joint2 != null)
		{
			var jointDef:B2GearJointDef = new B2GearJointDef();
			jointDef.joint1 = joint1;
			jointDef.joint2 = joint2;
			jointDef.ratio = ratio;
			
			Script.lastCreatedJoint = Engine.engine.world.createJoint(jointDef);
		}
	}*/
	
	
	// ==== destroy joint ==== //
	
	public static function destroyJoint(joint:B2Joint)
	{
		if (joint != null)
		{
			Engine.engine.world.destroyJoint(joint);
		}
	}
}
