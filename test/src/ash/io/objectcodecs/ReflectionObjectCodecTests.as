package ash.io.objectcodecs
{
	import ash.io.MockReflectionObject;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isNull;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	
	public class ReflectionObjectCodecTests
	{
		private var object : MockReflectionObject;
		private var encoded : Object;
		private var decoded : Object;
		
		[Before]
		public function createReflection() : void
		{
			object = new MockReflectionObject();
			object.intVariable = -4;
			object.uintVariable = 27;
			object.numberVariable = 23.678;
			object.stringVariable = "A test string";
			object.booleanVariable = true;
			object.fullAccessor = 13;
			object.pointVariable = new Point( 2, 3 );
			object.rectVariable = new Rectangle( 1, 2, 3, 4 );
			var codecManager : CodecManager = new CodecManager();
			codecManager.addReflectableType( Point );
			var encoder : ReflectionObjectCodec = new ReflectionObjectCodec( codecManager );
			encoded = encoder.encode( object );
			decoded = encoder.decode( encoded );
		}
		
		[After]
		public function clearReflection() : void
		{
			object = null;
			encoded = null;
			decoded = null;
		}
		
		[Test]
		public function encodingReturnsCorrectType() : void
		{
			assertThat( encoded.type, equalTo( "ash.io::MockReflectionObject" ) );
		}
		
		[Test]
		public function encodingReturnsIntVariable() : void
		{
			assertThat( encoded.properties.intVariable.value, equalTo( object.intVariable ) );
		}
		
		[Test]
		public function encodingReturnsUintVariable() : void
		{
			assertThat( encoded.properties.uintVariable.value, equalTo( object.uintVariable ) );
		}
		
		[Test]
		public function encodingReturnsNumberVariable() : void
		{
			assertThat( encoded.properties.numberVariable.value, equalTo( object.numberVariable ) );
		}
		
		[Test]
		public function encodingReturnsBooleanVariable() : void
		{
			assertThat( encoded.properties.booleanVariable.value, equalTo( object.booleanVariable ) );
		}
		
		[Test]
		public function encodingReturnsStringVariable() : void
		{
			assertThat( encoded.properties.stringVariable.value, equalTo( object.stringVariable ) );
		}
		
		[Test]
		public function encodingReturnsReflectableObjectVariable() : void
		{
			assertThat( encoded.properties.pointVariable.type, equalTo( "flash.geom::Point" ) );
			assertThat( encoded.properties.pointVariable.properties.x.value, equalTo( object.pointVariable.x ) );
			assertThat( encoded.properties.pointVariable.properties.y.value, equalTo( object.pointVariable.y ) );
		}
		
		[Test]
		public function encodingReturnsNullForReflectableNullVariable() : void
		{
			assertThat( encoded.properties.point2Variable.value, isNull() );
		}
		
		[Test]
		public function encodingDoesntReturnNonReflectableVariable() : void
		{
			assertThat( encoded.properties.hasOwnProperty( "rectVariable" ), isFalse() );
		}
		
		[Test]
		public function encodingDoesntReturnNonReflectableVariableWhenNull() : void
		{
			assertThat( encoded.properties.hasOwnProperty( "rect2Variable" ), isFalse() );
		}
		
		[Test]
		public function encodingReturnsFullAccessor() : void
		{
			assertThat( encoded.properties.fullAccessor.value, equalTo( object.fullAccessor ) );
		}

		[Test]
		public function decodingReturnsCorrectType() : void
		{
			assertThat( decoded, instanceOf( MockReflectionObject ) );
		}
		
		[Test]
		public function decodingReturnsIntVariable() : void
		{
			assertThat( decoded.intVariable, equalTo( object.intVariable ) );
		}
		
		[Test]
		public function decodingReturnsUintVariable() : void
		{
			assertThat( decoded.uintVariable, equalTo( object.uintVariable ) );
		}
		
		[Test]
		public function decodingReturnsNumberVariable() : void
		{
			assertThat( decoded.numberVariable, equalTo( object.numberVariable ) );
		}
		
		[Test]
		public function decodingReturnsBooleanVariable() : void
		{
			assertThat( decoded.booleanVariable, equalTo( object.booleanVariable ) );
		}
		
		[Test]
		public function decodingReturnsStringVariable() : void
		{
			assertThat( decoded.stringVariable, equalTo( object.stringVariable ) );
		}
		
		[Test]
		public function decodingReturnsReflectableObjectVariable() : void
		{
			assertThat( decoded.pointVariable, instanceOf( Point ) );
			assertThat( decoded.pointVariable.x, equalTo( object.pointVariable.x ) );
			assertThat( decoded.pointVariable.y, equalTo( object.pointVariable.y ) );
		}
		
		[Test]
		public function decodingReturnsFullAccessor() : void
		{
			assertThat( decoded.fullAccessor, equalTo( object.fullAccessor ) );
		}
	}
}
