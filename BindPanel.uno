using Fuse.Controls;

using Uno;
using Uno.UX;

using Fuse;
using Fuse.Designer;
using Fuse.Elements;
using Fuse.Scripting;
using Fuse.Triggers;

public class BindPanel : Panel {

	public static readonly StyleProperty<BindPanel, float> SizeXProperty
		= new StyleProperty<BindPanel, float>(0.0F, null, SetSizeX, GetSizeX);

	public static readonly StyleProperty<BindPanel, float> SizeYProperty
		= new StyleProperty<BindPanel, float>(0.0F, null, SetSizeY, GetSizeY);

	// public event SizeChangedHandler<float2> SizeChanged;

	float2 _size = float2(5,5);
	public float SizeX
	{
		get { return _size.X; }
		set { 
			debug_log "SizeX.set: " + value;
			SizeXProperty.Set(this, value);
		}
	}
	public float SizeY
	{
		get { return _size.Y; }
		set { 
			debug_log "SizeY.set: " + value;
			SizeYProperty.Set(this, value);
		}
	}


	static float GetSizeX(BindPanel p)
	{
		debug_log "static GetSizeX " + p._size;
		return p._size.X;
	}
	static float GetSizeY(BindPanel p)
	{
		debug_log "static GetSizeY " + p._size;
		return p._size.Y;
	}
	static void SetSizeX(BindPanel p, float sizeX)
	{
		debug_log "static SetSizeX " + sizeX;
		p._size.X = sizeX;
	}
	static void SetSizeY(BindPanel p, float sizeY)
	{
		debug_log "static SetSizeY " + sizeY;
		p._size.Y = sizeY;
	}

	public void SetSizeX(float sizeX, object origin)
	{
		debug_log "dynamic SetSizeX " + sizeX;
		_size.X = sizeX;
		SizeXProperty.SetLocalState(this);
	}

	public void SetSizeY(float sizeY, object origin)
	{
		debug_log "dynamic SetSizeY " + sizeY;
		_size.Y = sizeY;
		SizeYProperty.SetLocalState(this);
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
			// SetSizeX(ActualSize.X, this);
			// SetSizeY(ActualSize.Y, this);
			SizeX = ActualSize.X;
			SizeY = ActualSize.Y;
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