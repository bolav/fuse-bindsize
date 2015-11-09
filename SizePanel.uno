using Fuse;
using Fuse.Controls;
using Fuse.Scripting;
using Fuse.Reactive;

public class SizePanel : Panel {

	static SizePanel mySp;

	public SizePanel() 
	{
		mySp = this;
	}

	static SizePanel()
	{
		Register("SizePanel", CreateModule());

	}

	public static IModule CreateModule()
	{
	  return new NativeModule(
	  	new NativeFunction("GetWidthJS", (NativeCallback)GetWidthJS),
	  	new NativeFunction("GetHeightJS", (NativeCallback)GetHeightJS)
	  );
	}

	static object GetWidthJS(Context c, object[] args)
	{
		double d = mySp.ActualSize.X;
		return d;
	}

	static object GetHeightJS(Context c, object[] args)
	{
		double d = mySp.ActualSize.Y;
		return d;

	}

	static void Register(string moduleId, IModule module)
	{
		Uno.UX.Resource.SetGlobalKey(module, moduleId);
	}


}