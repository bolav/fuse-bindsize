using Fuse.Controls;

using Uno;
using Uno.UX;

using Fuse;
using Fuse.Designer;
using Fuse.Elements;
using Fuse.Scripting;
using Fuse.Triggers;

public class Float2ChangedArgs: ValueChangedArgs<float2>, IScriptEvent
{
	public Float2ChangedArgs(float2 value, object origin): base(value, origin)
	{
	}

	void IScriptEvent.Serialize(IEventSerializer s)
	{
		s.AddDouble("Value", Value.X);
		// s.AddDouble("Y", Value.Y);
	}
}


public class BindPanel : Panel {

	public static readonly StyleProperty<BindPanel, float2> SizeProperty
		= new StyleProperty<BindPanel, float2>(float2(0,0), null, SetSize, GetSize);

	// public event SizeChangedHandler<float2> SizeChanged;

	float2 _size = float2(5,5);
	[Group("Common"), UXValueChangedEvent("SetSize", "SizeChanged"), UXContent]
	public float2 Size
	{
		get { return _size; }
		set { 
			debug_log "Size.set: " + value;
			SizeProperty.Set(this, value);
		}
	}

	static float2 GetSize(BindPanel p)
	{
		debug_log "static GetSize " + p._size;
		return p._size;
	}
	static void SetSize(BindPanel p, float2 size)
	{
		debug_log "static SetSize " + size;
		p._size = size;
		p.OnSizeChanged(size, null);
	}
	public void SetSize(float2 size, object origin)
	{
		debug_log "dynamic SetSize " + size;
		_size = size;
		SizeProperty.SetLocalState(this);
		OnSizeChanged(size, origin);
	}

	public event ValueChangedHandler<float2> SizeChanged;

	protected void OnSizeChanged(float2 newSize, object origin) {
		if (SizeChanged != null)
		{
			debug_log "Dynamic Size change";
			var args = new Float2ChangedArgs(newSize, origin);
			debug_log "Running sizechanged " + SizeChanged;
			SizeChanged(this, args);
		}
	}

	public override void InvalidateVisual()
	{
		debug_log "";
		debug_log "------ STARTING --------";
		debug_log "old: " + _size;

		base.InvalidateVisual();
		if (_size != ActualSize) {
			debug_log "now: " + ActualSize;
			// Size = ActualSize;
			// OnSizeChanged(ActualSize, this);
			SetSize(ActualSize, this);
			debug_log "aft: " + _size;
		}
		// debug_log "InvalidateVisual: " + ActualSize;
		// SetSize(ActualSize, this);
		// debug_log "size: " + _size;
		// debug_log "sp.get: " + SizeProperty.Get(this);
		// SizeProperty.Set(this, ActualSize);
	}

	/* 
	protected void OnSizeChanged(float2 newSize, object origin)
	{
		if (SizeChanged != null)
		{
			// var args = new StringChangedArgs(newString, origin);
			SizeChanged(this, null);
		}
	}*/




}