using Fuse.Controls;

using Uno;
using Uno.UX;

using Fuse;
using Fuse.Designer;
using Fuse.Elements;
using Fuse.Scripting;
using Fuse.Triggers;

public class BindPanel : Panel {

	float2 _size = float2(5,5);
	public float2 Size {
		get { return _size; }
		set { 
			debug_log "Setting size " + value;
			_size = value; }
	}

	public override void InvalidateVisual()
	{
		debug_log "";
		debug_log "------ STARTING --------";
		debug_log "old: " + _size;

		base.InvalidateVisual();
		if (_size != ActualSize) {
			debug_log "now: " + ActualSize;
			Size = ActualSize;
			debug_log "aft: " + _size;
			foreach (var b in Behaviors) {
				debug_log "b: " + b;
				if (b is Fuse.Reactive.DataBinding<float2>) {
					var db = b as Fuse.Reactive.DataBinding<float2>;
					debug_log "Is a DataBinding";
					// db.SetValue(ActualSize);
				}
			}
		}
	}


}