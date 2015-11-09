using Fuse.Controls;

using Uno;
using Uno.UX;

using Fuse;
using Fuse.Designer;
using Fuse.Elements;
using Fuse.Scripting;
using Fuse.Triggers;

public class BindPanel : Panel {

	public static readonly StyleProperty<BindPanel, float2> SizeProperty
		= new StyleProperty<BindPanel, float2>(float2(0,0), OnSizePropertyChanged);
		// = new StyleProperty<BindPanel, float2>(float2(0,0), null, SetSize, GetSize);

	// public event SizeChangedHandler<float2> SizeChanged;

	public event EventHandler SizePropertyChanged;

	protected static void OnSizePropertyChanged(BindPanel p)
	{
		debug_log "Static Size Change";
		p.OnSizePropertyChanged();
	}


	protected void OnSizePropertyChanged()
	{
		debug_log "Dynamic Size change";
		if (SizePropertyChanged != null)
			SizePropertyChanged(this, EventArgs.Empty);
	}


	float2 _size = float2(5,5);
	public float2 Size
	{
		get { return _size; }
		set { 
			debug_log "Size.set: " + value;
			SizeProperty.Set(this, value); // This should be disabled for readonly
		}
	}

	static float2 GetSize(BindPanel p)
	{
		debug_log "static GetSize " + p._size;
		return p._size;
	}
	static void SetSize(BindPanel p, float2 size)
	{
		debug_log "static SetSize";
		p._size = size;
		// t.OnSizeChanged(value, null);
	}
	public void SetSize(float2 size, object origin)
	{
		debug_log "dynamic SetSize " + size;
		SizeProperty.SetLocalState(this);
		SizeProperty.Set(this, size); // This should be disabled for readonly
		_size = size;
		// debug_log("Setting sp: " + size);
		// OnSizeChanged(size, origin);
	}

	public override void InvalidateVisual()
	{
		base.InvalidateVisual();
		if (_size != ActualSize) {
			debug_log "now: " + ActualSize;
			OnSizePropertyChanged();
			Size = ActualSize;
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